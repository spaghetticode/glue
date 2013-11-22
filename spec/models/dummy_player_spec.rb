require 'spec_helper'

describe DummyPlayer do
  it { subject.should have(2).error_on :rfid }

  it 'is valid' do
    build_dummy_player.should be_valid
  end
end
