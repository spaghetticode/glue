require 'spec_helper'

describe TableSettings do
  describe '::current' do
    it { subject.goals.should == 8 }
    it { subject.advantages.should == 1 }
    it { subject.max_minutes.should be_nil }

    it 'picks the last created record' do
      first   = TableSettings.create
      current = TableSettings.create
      TableSettings.current.should == current
    end
  end
end