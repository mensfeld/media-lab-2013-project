class MainController < ApplicationController

  skip_before_filter :authenticate_user!

  def index
    @places = Place.all
  end

end
