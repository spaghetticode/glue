require 'spec_helper'

describe Player do
  it 'removes "@" to twitter_name' do
    player = Player.create(twitter_name: '@babbeo')
    player.twitter_name.should == 'babbeo'
  end

  it { subject.total_score.should be_zero }

  describe '::from_data' do
    let(:data) { {'twitter_name' => 'asd', 'type' => 'DummyPlayer'} }

    it 'delegates to the subclass' do
      DummyPlayer.should_receive :find_or_create_from_data
      Player.from_data(data)
    end
  end

  describe '#increase_total_score' do
    it 'increases total_score' do
      subject.increase_total_score(5)
      subject.total_score.should == 5
    end
  end

  describe '::by_total_score' do
    it 'orders players by total_score' do
      first = Player.create total_score: 5
      last  = Player.create total_score: 2
      Player.by_total_score.should == [first, last]
    end
  end
end