require 'spec_helper'

describe Match do
  let(:team)  { create_team }
  let(:match) { create_match }

  it { should respond_to :winner }
  it { should respond_to :team_a }
  it { should respond_to :team_a }

  (1..4).each do |n|
    method = "player_#{n}"
    it { should respond_to method }
  end

  it 'is valid' do
    expect { create_match }.to_not raise_error
  end

  describe '#start' do
    it 'sets the match start time' do
      expect { match.start }.to change(match, :start_at)
    end
  end

  describe '#close' do
    it 'sets the match end time' do
      expect { match.close }.to change(match, :end_at)
    end
  end

  it 'requires teams' do
    subject.should have(1).error_on :team_a
    subject.should have(1).error_on :team_b
  end

  context 'when #end_at is not set' do
    it 'is is not closed' do
      match.should_not be_closed
    end
  end

  context 'when #end_at is set' do
    before { match.close }

    it 'is closed' do
      match.should be_closed
    end
  end

  describe '#current' do
    it 'returns the latest match according to #start_at' do
      recent = create_match :start_at => 1.hour.ago
      create_match :start_at => 1.day.ago
      Match.current.should == recent
    end
  end

  describe '#update_score' do
    let(:score) { {:team_a_score => '3', :team_b_score => '0'} }

    context 'when match is not closed' do
      it 'updates score' do
        expect { match.update_score(score) }.to change(match, :team_a_score).to 3
      end

      it 'returns true' do
        match.update_score(score).should be_true
      end
    end

    context 'when match is closed' do
      it 'returns false' do
        match.close
        expect { match.update_score(score) }.to_not change(match, :team_a_score).to 3
      end
    end
  end
end
