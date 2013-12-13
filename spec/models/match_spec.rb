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
    before { subject.stub update_winners: nil, update_losers: nil }

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

  describe '#as_json' do
    it 'includes expected methods' do
      1.upto 4 do |n|
        subject.should_receive "player_#{n}_name"
      end
      subject.as_json
    end

    it 'has expected keys' do
      %w[end_at start_at player_1 player_2 player_3 player_4 team_a_score team_b_score].each do |key|
        subject.as_json.keys.should include key
      end
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

    describe '#player_1_name' do
      let(:player) { DummyPlayer.new twitter_name: 'asd' }

      it 'delegates to player_1 twitter name' do
        player.should_receive :twitter_name
        Match.new(player_1: player).player_1_name
      end

      context 'when player has no twitter_name' do
        before {player.stub twitter_name: nil }

        it 'delegates also to player_1 rfid' do
          player.should_receive :rfid
          Match.new(player_1: player).player_1_name
        end
      end

      context 'when match has no player 1' do
        it 'is nil' do
          Match.new.player_1_name.should be_nil
        end
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
        before do
          4.times { |n| subject.send "player_#{n+1}=", Player.new }
          subject.team_a_score = 4
          subject.team_b_score = 2
        end

        it 'sets #end_at attribute' do
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

    describe '::create_with_players' do
      let(:dummy_params) do
        (1..4).to_a.inject Hash.new do |hash, n|
          hash.update "player_#{n}" => {'twitter_name' => "asd#{n}", 'type' => 'DummyPlayer'}
        end
      end

      it 'creates new players when they dont exist' do
        expect do
          Match.create_with_players(dummy_params)
        end.to change(DummyPlayer, :count).by 4
      end

      it 'creates a new match' do
        expect do
          Match.create_with_players(dummy_params)
        end.to change(Match, :count).by 1
      end

      it 'returns a match' do
        Match.create_with_players(dummy_params).should be_a Match
      end
    end
  end

  context 'when match is not closed' do
    it { subject.losers.should be_nil }
    it { subject.winners.should be_nil }
    it { subject.losers_score.should be_nil }
    it { subject.winners_score.should be_nil }
  end

  context 'when match is closed' do
    before { subject.end_at = Time.now }

    context 'when team_a is winner' do
      before do
        subject.team_a_score = 5
        subject.team_b_score = 2
      end

      it { subject.winners_score.should == 5 }
      it { subject.losers_score.should == 2 }
      it { subject.should be_team_a_winner }

      it '#losers includes player_3 and player_4' do
        4.times { |n| subject.send("player_#{n+1}=", Player.new) }
        subject.losers.should == [subject.player_3, subject.player_4]
      end

      it '#winners includes player_1 and player_2' do
        4.times { |n| subject.send("player_#{n+1}=", Player.new) }
        subject.winners.should == [subject.player_1, subject.player_2]
      end
    end

    context 'when team_b is winner' do
      before do
        subject.team_a_score = 2
        subject.team_b_score = 5
      end

      it { subject.winners_score.should == 5 }
      it { subject.losers_score.should == 2 }
      it { subject.should_not be_team_a_winner }

      it '#losers includes player_1 and player_2' do
        4.times { |n| subject.send("player_#{n+1}=", Player.new) }
        subject.losers.should == [subject.player_1, subject.player_2]
      end

      it '#winners includes player_3 and player_4' do
        4.times { |n| subject.send("player_#{n+1}=", Player.new) }
        subject.winners.should == [subject.player_3, subject.player_4]
      end
    end
  end

  describe '#update_winners' do
    context 'when player_1 and player_2 are the same' do
      let(:player) { DummyPlayer.new }

      before { subject.stub winners: [player, player], winners_score: 5 }

      it 'increases the player won matches only once' do
        expect { subject.update_winners }.to change(player, :won).by 1
      end
    end
  end
end