require 'spec_helper'

describe Team do
  it_behaves_like 'auto naming'

  let(:team)     { create_team }
  let(:player )  { create_registered_player }
  let(:player_1) { create_dummy_player }
  let(:player_2) { create_registered_player }


  it 'is valid' do
    expect { create_team }.to_not raise_error
  end

  it { should respond_to :player_1 }
  it { should respond_to :player_2 }
  it { should respond_to :matches }

  it { should have(1).error_on :player_1 }
  it { should have(1).error_on :player_2 }

  describe '.find_by_players' do

    context 'when team with given players doesnt exist' do
      it 'is nil' do
        Team.find_by_players(player_1, player_2).should be_nil
      end
    end

    context 'when team with given players exist' do
      let!(:team) { create_team player_1: player_1, player_2: player_2 }

      it 'finds the team with given players' do
        Team.find_by_players(player_1, player_2).should == team
      end

      it 'doesnt matter the players order' do
        Team.find_by_players(player_2, player_1).should == team
      end
    end
  end

  describe '.find_by_players_or_build' do
    it 'tries to delegate to .find_by_players method' do
      Team.should_receive(:find_by_players).with(player_1, player_2)
      Team.find_by_players_or_build(player_1, player_2)
    end

    context 'when no team exists with given players' do
      it 'builds a new team' do
        Team.find_by_players_or_build(player_2, player_1).should be_new_record
      end
    end
  end
end
