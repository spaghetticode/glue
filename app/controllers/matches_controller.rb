class MatchesController < ApplicationController
  def show
    @match = Match.current
  end
end
