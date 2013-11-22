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
    let(:params) { { :id => 42, :match => {:team_a_score => '3', :team_b_score => '1'}} }
    context 'when score can be updated' do
      it 'is successful' do
        match = mock(update_score: true)
        Match.stub(find: match)
        put 'update', params
        response.should be_success
      end
    end

    context 'when score cannot be updated' do
      it 'fails' do
        match = mock(update_score: false)
        Match.stub(find: match)
        put 'update', params
        response.should be_payment_required
      end
    end
  end
end
