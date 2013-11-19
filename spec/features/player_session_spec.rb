require 'spec_helper'

describe 'logging in ' do
  context 'when player inserts the correct password/email combo' do
    let(:password) { 'secret123' }
    let(:player) { create_player :password => password, :password_confirmation => password }

    it 'logs the player in' do
      login player, password
      page.should have_content 'Signed in successfully'
    end
  end
end