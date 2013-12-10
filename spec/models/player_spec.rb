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

  describe '::from_data' do
    let(:data) { {twitter_name: 'asd', type: 'DummyPlayer'} }

    it 'delegates to the subclass' do
      DummyPlayer.should_receive :find_or_create_from_data
      Player.from_data(data)
    end
  end
end