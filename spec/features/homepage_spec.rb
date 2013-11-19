require 'spec_helper'

describe 'homepage' do
  it 'works' do
    visit '/'
    page.should have_content 'Welcome'
  end
end