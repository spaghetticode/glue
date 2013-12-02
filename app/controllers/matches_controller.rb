class MatchesController < ApplicationController
  layout 'matches'

  def show
    @match = Match.current
  end
end
