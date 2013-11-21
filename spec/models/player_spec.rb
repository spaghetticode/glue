require 'spec_helper'

describe Player do
  it_behaves_like 'auto naming'
  let(:twitter_id) { 'spaghetticode' }
  let(:player)     { create_player }

  it { should have(2).errors_on :rfid }

  it 'is valid' do
    expect { create_player }.to_not raise_error
  end

  it { should respond_to :teams }
  it { should respond_to :teams_as_player_1 }
  it { should respond_to :teams_as_player_2 }

  it 'requires unique rfid' do
    invalid = build_player :rfid => player.rfid
    invalid.should have(1).error_on :rfid
  end

  it 'removes @ to twitter_id, when present' do
    player = create_player :twitter_id => "@#{twitter_id}"
    player.twitter_id.should == twitter_id
  end

  it 'requires unique twitter_id' do
    player.update_attribute :twitter_id, twitter_id
    invalid = build_player :twitter_id => twitter_id
    invalid.should have(1).error_on :twitter_id
  end

  describe '#teams' do
    it 'include teams where player is player_2' do
      team = create_team :player_1 => player
      player.teams.should include team
    end

    it 'include teams where player is player_2' do
      team = create_team :player_2 => player
      player.teams.should include team
    end
  end
end
