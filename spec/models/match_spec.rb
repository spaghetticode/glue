require 'spec_helper'

describe Match do
  let(:match) { create_match }

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
end
