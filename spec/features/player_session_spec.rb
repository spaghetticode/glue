require 'spec_helper'

describe 'Login and Logout process do' do
  let(:password) { 'secret123' }
  let(:player) { create_registered_player :password => password, :password_confirmation => password }

  describe 'Login' do
    context 'when player inserts the correct password/email combo' do
      it 'logs the player in' do
        login player, password
        page.should have_content 'Signed in successfully'
      end
    end
  end

  describe 'Logout' do
    it 'logs out logged player' do
      login player, password
      within '.navbar.navbar-fluid-top' do
        click_link 'sign out'
      end
      page.should have_content 'Signed out successfully'
    end
  end
end

