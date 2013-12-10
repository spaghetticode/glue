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
end