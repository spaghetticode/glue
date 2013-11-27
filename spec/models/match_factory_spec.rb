require 'spec_helper'

describe MatchFactory do
  let(:params) { Hash.new }
  subject { MatchFactory.new(params) }

  it 'has player accessors' do
    (1..4).each do |n|
      should respond_to "player_#{n}"
      should respond_to "player_#{n}="
    end
  end

  %w[team_a team_b match].each do |accessor|
    it "has #{accessor} accessor" do
      should respond_to accessor
      should respond_to "#{accessor}="
    end
  end

  it { should respond_to :params }

  describe '#build_player' do
    let(:rfid)   { Player.random_rfid }
    let(:dummy)  { create_dummy_player }
    let(:player) { create_registered_player }

    context 'when player with matching rfid doesnt exist' do
      it 'builds a dummy player' do
        subject.params.merge(player_2: rfid)
        subject.build_player_2
        subject.player_2.should be_a DummyPlayer
      end
    end

    context 'when player already exists' do
      context 'when existing player is dummy' do
        it 'finds the dummy player' do
          subject.params.merge!(player_1: dummy.rfid)
          expect do
            subject.build_player_1
          end.to change(subject, :player_1).to dummy
        end
      end

      context 'when existing player is registered' do
        it 'finds registered player' do
          subject.params.merge!(player_3: player.rfid)
          expect do
            subject.build_player_3
          end.to change(subject, :player_3).to player
        end
      end
    end
  end

  describe '#build_players' do
    (1..4).each do |n|
      player = "player_#{n}"
      it "builds #{player}" do
        expect { subject.build_players }.to change(subject, player)
      end
    end
  end

  describe '#build_teams' do
    let(:team_a) { create_team }
    let(:team_b) { create_team }

    context 'when teams with given players exist' do
      before do
        subject.params.merge!({
          player_1: team_a.player_1.rfid,
          player_2: team_a.player_2.rfid,
          player_3: team_b.player_1.rfid,
          player_4: team_b.player_2.rfid
        })
        subject.build_players
      end

      it 'picks the existing team as #team_a' do
        expect { subject.build_teams }.to change(subject, :team_a).to team_a
      end

      it 'picks the existing team as #team_b' do
        expect { subject.build_teams }.to change(subject, :team_b).to team_b
      end
    end

    context 'when teams with given players dont exist' do
      before { subject.build_players }

      it 'builds new teams' do
        subject.build_teams
        subject.team_a.should be_new_record
        subject.team_b.should be_new_record
      end
    end
  end

  describe '#build_match' do
    before do
      subject.build_players
      subject.build_teams
    end

    it 'builds a new match' do
      expect { subject.build_match }.to change(subject, :match)
    end
  end

  describe '#save' do
    it 'tries to save players, teams and match' do
      %w[save_players save_teams save_match].each do |method|
        subject.should_receive(method).and_return(true)
      end
      subject.save
    end

    context 'when resources can be created' do
      it 'is successful' do
        params = {
          player_1: Player.random_rfid,
          player_2: Player.random_rfid,
          player_3: Player.random_rfid,
          player_4: Player.random_rfid
        }
        factory = MatchFactory.new(params)
        factory.save.should be_true
      end
    end
  end

  describe '#save_players' do
    it 'tries to save players' do
      (1..4).each do |n|
        player = double.tap { |p| p.should_receive :save }.as_null_object
        subject.send("player_#{n}=", player)
      end
      subject.save_players
    end
  end
end