require 'spec_helper'

describe Player do
  describe '::without_rfid' do
    it 'picks players without rfid' do
      picked = Player.create
      Player.create(rfid: 'somerfidvalue')
      Player.without_rfid.should == [picked]
    end
  end

  it 'adds "@" to twitter_name' do
    player = Player.create(twitter_name: 'babbeo')
    player.twitter_name.should == '@babbeo'
  end

  it 'doesnt add another "@" when already present' do
    player = Player.create(twitter_name: '@babbeo')
    player.twitter_name.should == '@babbeo'
  end
end