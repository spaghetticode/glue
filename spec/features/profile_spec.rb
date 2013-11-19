require 'spec_helper'

describe 'profile' do
  let(:password) { 'secret123' }
  let(:player) { create_player :password => password, :password_confirmation => password }

  before { login player, password }

  it 'shows the user profile' do
    visit profile_path
    page.should have_content 'Profile'
    page.should have_content player.email
    page.should have_content 'edit profile'
  end
end