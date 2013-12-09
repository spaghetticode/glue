require 'spec_helper'

describe Player do
  describe '::without_rfid' do
    it 'picks players without rfid' do
      picked = Player.create
      Player.create(rfid: 'somerfidvalue')
      Player.without_rfid.should == [picked]
    end
  end
end