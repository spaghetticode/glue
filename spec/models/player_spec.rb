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

  describe '::by_won_matches' do
    it 'orders players by won matches' do
      first  = Player.create won: 5
      last   = Player.create won: 2
      second = Player.create won: 4
      Player.by_won_matches.should == [first, second, last]
    end
  end
end