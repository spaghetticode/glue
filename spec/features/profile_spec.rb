require 'spec_helper'

describe 'profile' do
  let(:password) { 'secret123' }
  let(:player) { create_player :password => password, :password_confirmation => password }

  before do
    login player, password
  end

  it 'shows the user profile' do
    visit profile_path
    page.should have_content 'Profile'
  end
end