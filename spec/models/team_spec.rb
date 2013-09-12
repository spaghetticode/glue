require 'spec_helper'

describe Team do
  it_behaves_like 'auto naming'

  it 'is valid' do
    expect { create_team }.to_not raise_error
  end

  private

  def create_team(opts={})
    FactoryGirl.create :team, opts
  end
end
