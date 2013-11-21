require 'spec_helper'

describe Match do
  let(:team)  { create_team }
  let(:match) { create_match }

  it { should respond_to :winner }
  it { should respond_to :team_a }
  it { should respond_to :team_a }

  (1..4).each do |n|
    method = "player_#{n}"
    it { should respond_to method }
  end

  it 'is valid' do
    expect { create_match }.to_not raise_error
  end

  describe '#start' do
    it 'sets the match start time' do
      expect { match.start }.to change(match, :start_at)
    end
  end

  describe '#end' do
    it 'sets the match end time' do
      expect { match.end }.to change(match, :end_at)
    end
  end

  it 'requires teams' do
    subject.should have(1).error_on :team_a
    subject.should have(1).error_on :team_b
  end

  describe '#current' do
    it 'returns the latest match according to #start_at' do
      recent = create_match :start_at => 1.hour.ago
      create_match :start_at => 1.day.ago
      Match.current.should == recent
    end
  end
end
