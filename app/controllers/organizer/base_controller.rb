class Organizer::BaseController < ApplicationController

  before_filter :only_for_organizers

  private

  def only_for_organizers
    raise ActiveRecord::RecordNotFound unless current_user.organizer?
  end
  
end
