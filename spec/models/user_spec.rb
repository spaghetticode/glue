require 'spec_helper'

describe User do
  it 'is valid' do
    expect { create_user }.to_not raise_error
  end
end
