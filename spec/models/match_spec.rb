require 'spec_helper'

describe Match do
  let(:match) { create_match }
  let(:team)  { create_team }

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

  it { should respond_to :winner }
  it { should respond_to :teams }

  describe '#add_team' do
    it 'adds the team to the match' do
      match.add_team team
      match.teams.should include team
    end

    it 'allows to add max 2 teams' do
      2.times { match.add_team create_team }
      not_added = create_team
      match.add_team not_added
      match.teams.should_not include not_added
    end
  end
end
