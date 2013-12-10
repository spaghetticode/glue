require 'spec_helper'

describe DummyPlayer do
  it { subject.should be_a Player }

  it { subject.type.should == 'DummyPlayer' }

  it 'requires twitter_name' do
    subject.valid?
    subject.errors[:twitter_name].should_not be_empty
  end
end