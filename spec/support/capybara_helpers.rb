module CapybaraHelpers
  def login(player, password)
    visit new_registered_player_session_path
    fill_in 'Email',    with: player.email
    fill_in 'Password', with: password
    click_button 'Sign in'
  end
end