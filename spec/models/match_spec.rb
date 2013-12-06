require 'pry'
require 'spec_helper'

describe Match do
  let(:now) { Time.new(2013, 12, 25, 23, 00, 00) }
  let(:one_min_ago ) { Time.new(2013, 12, 25, 22, 58, 44) }
  let(:settings) { double(advantages: 2, goals: 5, max_minutes: 10) }


  it { subject.end_at.should be_nil }
  it { subject.start_at.should be_nil }
  it { subject.team_a_score.should be_zero }
  it { subject.team_b_score.should be_zero }

  it 'automatically starts match on creation' do
    expect { subject.save }.to change(subject, :start_at)
  end

  it 'delegates #settings to TableSettings.current' do
    TableSettings.should_receive :current
    subject.settings
  end

  it 'delegates #now to Time' do
    Time.should_receive :now
    subject.now
  end

  describe '#minutes' do
    before { subject.stub now: now }

    describe 'when match has not started yet' do
      it { subject.minutes.should be_zero }
    end

    it 'calculates the difference from #now and #start_at in minutes' do
      subject.stub start_at: one_min_ago
      subject.minutes.should == 1
    end
  end

  describe '#close' do
    it 'changes #end_at' do
      expect { subject.close }.to change subject, :end_at
    end
  end

  describe '#increase_team_score' do
    it 'increases the team score' do
      expect { subject.increase_team_score :a }.to change(subject, :team_a_score).by 1
    end

    it 'doesnt change the other team score' do
      expect { subject.increase_team_score :a }.to_not change(subject, :team_b_score).by 1
    end
  end

  describe '#time_over?' do
    context 'when settings.max_minutes is not set' do
      before { subject.stub settings: double(max_minutes: nil) }

      it { should_not be_time_over }
    end
  end

  describe '#closed?' do
    before { subject.stub settings: settings }

    context 'when the match has #end_at attribute' do
      before { subject.end_at = Time.now }

      it { should be_closed }
    end

    context 'when time is over' do
      before { subject.stub time_over?: true }

      it { should be_closed }
    end

    context 'when max goals number is reached' do
      before { subject.stub max_goals_reached?: true }

      it { should_not be_closed }

      context 'when also goals delta is reached' do
        before { subject.stub goals_delta_reached?: true }

        it { should be_closed }
      end
    end

    context 'when only goals delta is reached' do
      before { subject.stub goals_delta_reached?: true }

      it { should_not be_closed }
    end

    describe '#goals_delta_reached?' do
      context 'when delta is equal or greater than settings advantages' do
        before { subject.team_a_score = 2}

        it { subject.goals_delta_reached?.should be_true }
      end

      context 'when delta is lower than settings advantages' do
        it { subject.goals_delta_reached?.should be_false }
      end
    end

    describe '#max_goals_reached?' do
      context 'when a team has reached the settings goals value' do
        before { subject.team_b_score = subject.settings.goals }

        it { subject.max_goals_reached?.should be_true }
      end

      context 'when the team has not reached the settings goals value' do
        it { subject.max_goals_reached?.should be_false }
      end
    end

    describe '#update_score' do
      before { subject.stub settings: settings }

      context 'when match is closed' do
        before { subject.stub(closed?: true) }

        it 'returns nil' do
          subject.update_score(:b).should be_nil
        end
      end

      context 'when increasing the score should close the match' do
        it 'sets #end_at attribute' do
          subject.team_a_score = 4
          subject.team_b_score = 2
          expect { subject.update_score(:a) }.to change subject, :end_at
        end
      end

      context 'when increasing the score should not close the match' do
        it 'doesnt set #end_at attribute' do
          subject.team_a_score = 0
          subject.team_b_score = 2
          expect { subject.update_score(:a) }.to_not change subject, :end_at
        end
      end
    end
  end
end