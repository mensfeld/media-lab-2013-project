class Owner::BaseController < ApplicationController

  before_filter :only_for_owners

  private

  def only_for_owners
    raise ActiveRecord::RecordNotFound unless current_user.owner?
  end

end
