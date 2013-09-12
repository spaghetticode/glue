require 'spec_helper'

describe Player do
  it { should have(2).errors_on :rfid }

  it 'is valid' do
    expect { create_player }.to_not raise_error
  end

  context 'when no name is provided' do
    it 'sets a random name on validations' do
      player = Player.new
      expect { player.valid? }.to change player, :name
    end
  end

  context 'when name is already provided' do
    it 'sets a random name on validations' do
      player = Player.new :name => 'baluba'
      expect { player.valid? }.to_not change player, :name
    end
  end

  private

  def create_player(opts={})
    FactoryGirl.create :player, opts
  end
end
