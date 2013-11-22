require 'spec_helper'

describe Player do
  describe '.find_registered_or_dummy' do
    let(:rfid)   { SecureRandom.base64(8) }
    let(:dummy)  { create_dummy_player :rfid => rfid }
    let(:player) { create_registered_player :rfid => rfid }

    context 'when no player exists with given rfid' do
      it 'returns nil' do
        Player.find_registered_or_dummy(rfid).should be_nil
      end
    end

    context 'when dummy player exists with given rfid' do
      before { dummy }

      it 'finds the correct dummy player' do
        Player.find_registered_or_dummy(rfid).should == dummy
      end
    end

    context 'when registered player exists with given rfid' do
      before { player }

      it 'finds the correct registered player' do
        Player.find_registered_or_dummy(rfid).should == player
      end
    end

    # TODO are we really going to have dummy and registered players with same rfid?
    context 'when both dummy and registered player exist with given rfid' do
      before { dummy; player }

      it 'picks the registered player anyway' do
        Player.find_registered_or_dummy(rfid).should == player
      end
    end
  end
end