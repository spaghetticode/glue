require 'spec_helper'

describe Player do
  it_behaves_like 'auto naming'

  it { should have(2).errors_on :rfid }

  it 'is valid' do
    expect { create_player }.to_not raise_error
  end

  private

  def create_player(opts={})
    FactoryGirl.create :player, opts
  end
end
