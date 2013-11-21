require 'spec_helper'

describe 'profile' do
  let(:password) { 'secret123' }
  let(:new_rfid) { 'somethingfun' }
  let(:player)   { create_player :password => password, :password_confirmation => password }

  before { login player, password }

  it 'shows the user profile' do
    visit profile_path
    page.should have_content 'Profile'
    page.should have_content player.email
    page.should have_content 'edit profile'
  end

  it 'updates the user profile' do
    visit edit_profile_path
    fill_in 'Rfid', with: new_rfid
    click_button :update
    page.should have_content 'Your profile was successfully updated'
    page.should have_content new_rfid
  end
end