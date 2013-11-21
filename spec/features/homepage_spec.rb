require 'spec_helper'

describe 'homepage' do
  context 'when no match has been played' do
    it 'works' do
      visit '/'
      page.should have_content 'Welcome'
    end
  end
end