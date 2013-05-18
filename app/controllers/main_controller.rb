class MainController < ApplicationController

  skip_before_filter :authenticate_user!

  def index
    @places = Place.order(:created_at.desc).limit(5)
  end

end
