require 'pry'
require 'spec_helper'

describe DummyPlayer do
  def create_match_with(player, n)
    attrs = (1..4).to_a.inject Hash.new do |attrs, i|
      attrs.update "player_#{i}" => i == n ? player : DummyPlayer.create(twitter_name: "asd#{i}")
    end
    Match.create attrs
  end

  it { subject.should be_a Player }

  it { subject.type.should == 'DummyPlayer' }

  it 'requires twitter_name' do
    subject.valid?
    subject.errors[:twitter_name].should_not be_empty
  end

  describe '#matches association' do
    subject { DummyPlayer.create twitter_name: 'baubau' }

    it 'has expected matches' do
      first  = create_match_with subject, 1
      second = create_match_with subject, 2
      subject.matches.to_a.should =~ [first, second]
    end
  end

  describe '::find_or_create_from_data' do
    let(:data) { {type: 'DummyPlayer', twitter_name: 'myname'} }

    context 'when matching record exists' do
      let!(:record) { DummyPlayer.create twitter_name: 'myname' }

      it 'finds it' do
        expect do
          DummyPlayer.find_or_create_from_data(data)
        end.to_not change(Player, :count)
      end
    end

    context 'when matching record doesnt exist' do
      it 'finds it' do
        expect do
          DummyPlayer.find_or_create_from_data(data)
        end.to change(Player, :count).by 1
      end
    end
  end
end