class LandingController < ApplicationController

  layout 'landing'

  skip_before_filter :authenticate_user!

  def index
  end

end
