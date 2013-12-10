require 'spec_helper'

describe Player do
  it 'adds "@" to twitter_name' do
    player = Player.create(twitter_name: 'babbeo')
    player.twitter_name.should == '@babbeo'
  end

  it 'doesnt add another "@" when already present' do
    player = Player.create(twitter_name: '@babbeo')
    player.twitter_name.should == '@babbeo'
  end
end