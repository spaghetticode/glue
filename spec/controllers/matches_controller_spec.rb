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
    let :params  do
      {
        match: {
          player_1: build_dummy_player.rfid,
          player_2: build_dummy_player.rfid,
          player_3: build_dummy_player.rfid,
          player_4: build_dummy_player.rfid
        }
      }
    end

    context 'when match can be created' do
      before { controller.stub(match_created?: true) }

      it 'is successful' do
        post 'create', params
        response.should be_success
      end
    end

    context 'when match cannot be created' do
      before { controller.stub(match_created?: false) }

      it 'fails with unprocessable entity' do
        post 'create', params
        response.should be_unprocessable
      end
    end
  end

  describe 'PUT update' do
    let(:params) { { :id => 42, :match => {:team_a_score => '3', :team_b_score => '1'}} }

    context 'when score can be updated' do
      it 'is successful' do
        controller.stub(match_score_updated?: true)
        put 'update', params
        response.should be_success
      end
    end

    context 'when score cannot be updated' do
      before { controller.stub(match_score_updated?: false) }

      it 'fails with unprocessable entity' do
        put 'update', params
        response.should be_unprocessable
      end
    end
  end
end
