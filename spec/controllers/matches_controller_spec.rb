require 'spec_helper'

describe MatchesController do
  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end

    it 'looks for the current match' do
      Match.should_receive :current
      get 'show'
    end
  end

  describe 'POST create' do
    pending
  end

  describe 'PUT update' do
    pending
  end
end
