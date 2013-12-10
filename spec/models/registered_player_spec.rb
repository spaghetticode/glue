require 'spec_helper'

describe RegisteredPlayer do
  it 'requires rfid attribute' do
    subject.valid?
    subject.errors[:rfid].should_not be_empty
  end

  it 'is a registered player' do
    subject.type.should == 'RegisteredPlayer'
  end

  it 'is also a player' do
    subject.should be_a Player
  end

  describe '::find_or_create_from_data' do
    let(:data) { {'type' => 'RegisteredPlayer', 'rfid' => '1234'} }

    context 'when matching record exists' do
      let!(:record) { RegisteredPlayer.create rfid: '1234' }

      it 'finds it' do
        expect do
          RegisteredPlayer.find_or_create_from_data(data)
        end.to_not change(Player, :count)
      end
    end

    context 'when matching record doesnt exist' do
      it 'finds it' do
        expect do
          RegisteredPlayer.find_or_create_from_data(data)
        end.to change(Player, :count).by 1
      end
    end
  end
end