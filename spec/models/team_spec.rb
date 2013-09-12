require 'spec_helper'

describe Team do
  it_behaves_like 'auto naming'

  let(:team)    { create_team }
  let(:player ) { create_player }

  it 'is valid' do
    expect { create_team }.to_not raise_error
  end

  it { should respond_to :players }

  describe '#add_player' do
    it 'adds the player to the team' do
      team.add_player player
      team.players.should include player
    end

    it 'allows to add max 2 players' do
      2.times { team.add_player create_player }
      not_added = create_player
      team.add_player not_added
      team.players.should_not include not_added
    end
  end

  private

  def create_team(opts={})
    FactoryGirl.create :team, opts
  end

  def create_player(opts={})
    FactoryGirl.create :player, opts
  end
end
