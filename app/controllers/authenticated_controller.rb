# all controllers that require authentication should inherit from this one

class AuthenticatedController < ApplicationController
  before_filter :authenticate_player!
end
