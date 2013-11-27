require 'spec_helper'

describe 'show current match' do
  it 'shows the latest match results' do
    create_match :team_a_score => 3, :team_b_score => 0
    visit match_path
    page.find('#score_a').should have_content '3'
    page.find('#score_b').should have_content '0'
  end
end