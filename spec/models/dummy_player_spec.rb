require 'spec_helper'

describe DummyPlayer do
  it { subject.should have(2).error_on :rfid }

  it 'is valid' do
    build_dummy_player.should be_valid
  end

  it 'allows multiple empty emails' do
    3.times { create_dummy_player }
  end

  it 'picks names from the dummy_player_names.yml file' do
    subject.valid?
    DummyPlayer::DUMMY_NAMES.should include(subject.name)
  end

  describe '.set_unique_names' do
    it 'makes player names unique' do
      players = (0..3).map { create_dummy_player :name => 'allthesame' }
      DummyPlayer.set_unique_names(players)
      players.map(&:name).uniq.size.should == 4
    end
  end
end
