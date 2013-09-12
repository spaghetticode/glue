require 'spec_helper'

describe Player do
  it_behaves_like 'auto naming'

  let(:player) { create_player }

  it { should have(2).errors_on :rfid }

  it 'is valid' do
    expect { create_player }.to_not raise_error
  end

  it { should respond_to :teams }
end
