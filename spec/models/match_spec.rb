require 'spec_helper'

describe Match do
  it { subject.end_at.should be_nil }
  it { subject.start_at.should be_nil }
  it { subject.team_a_score.should be_zero }
  it { subject.team_b_score.should be_zero }

  it 'automatically starts match on creation' do
    expect { subject.save }.to change(subject, :start_at)
  end

  describe '#close' do
    it 'automatically sets the end_at attribute' do
      expect { subject.close }.to change(subject, :end_at)
    end
  end
end