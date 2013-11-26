class MatchesController < ApplicationController
  protect_from_forgery only: []


  def show
    @match = Match.current
  end

  def create
    if match_created?
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
    binding.pry
    if match_score_updated?
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def close
    close_match
    head :ok
  end

  private

  def match_score_updated?
    find_match
    @match.update_score(params[:match])
  end

  def match_created?
    MatchFactory.new(params).save
  end

  def close_match
    find_match
    @match.close
  end

  def find_match
    #@match = Match.find(params[:id])
    @match = Match.last
  end
end
