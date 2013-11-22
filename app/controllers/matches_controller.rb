class MatchesController < ApplicationController
  def show
    @match = Match.current
  end

  def create
    @match_factory = MatchFactory.new(params)
    if @match_factory.save
      head :created
    else
      head :unprocessable_entity
    end
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
    if update_score_successful?
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def update_score_successful?
    @match = Match.find(params[:id])
    @match.update_score(params[:match])
  end
end
