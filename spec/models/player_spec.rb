require 'spec_helper'

describe Player do
  it { should have(2).errors_on :rfid }

  it 'is valid' do
    expect { FactoryGirl.create :player }.to_not raise_error
  end

  it 'sets a random name on validations when name is not provided' do
    player = Player.new
    expect { player.valid? }.to change player, :name
  end

  private

  def create_player(opts={})
    FactoryGirl.create :player, opts
  end

  def build_player(opts={})
    FactoryGirl.build :player, opts
  end
end
