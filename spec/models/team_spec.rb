require 'spec_helper'

describe Team do
  it_behaves_like 'auto naming'

  let(:team)    { create_team }
  let(:player ) { create_player }

  it 'is valid' do
    expect { create_team }.to_not raise_error
  end

  it { should respond_to :player_1 }
  it { should respond_to :player_2 }
  it { should respond_to :matches }

  it { should have(1).error_on :player_1 }
  it { should have(1).error_on :player_2 }
end
