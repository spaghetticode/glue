class MatchesController < ApplicationController
  def show
    @match = Match.current
  end

  def create
    # creates a new match with given player rfids.
    # first tries to look for existing registered_players,
    # if not found looks for dummy_players, if not not found
    # creates a new dummy_player.
    # it looks for teams with given players, if not found
    # creates a new team.
    # once we have teams and players it creates a new match
    # the method returns a created header with the id of the match.
  end

  def update
    # looks for the match with given id and updates the score.
    @match = Match.find(params[:id])
    if @match.update_score(params[:match])
      head :ok
    else
      head :bad_request
    end
  end
end
