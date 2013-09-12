require 'spec_helper'

describe Team do
  it 'is valid' do
    expect { FactoryGirl.create :team }.to_not raise_error
  end

  context 'when no name is provided' do
    it 'sets a random name on validations' do
      team = Team.new
      expect { team.valid? }.to change team, :name
    end
  end

  context 'when name is already provided' do
    it 'sets a random name on validations' do
      team = Team.new :name => 'foggia'
      expect { team.valid? }.to_not change team, :name
    end
  end


  private

  def create_team(opts={})
    FactoryGirl.create :team, opts
  end
end
