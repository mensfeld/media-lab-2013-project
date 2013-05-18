class Owner::PlacesController < ActionController::Base

  before_filter :only_for_owners

  def index
    respond_with @places = current_user.places
  end

  def new
    respond_with @place = current_user.places.new
  end

  def create
    respond_with @place = current_user.places.create(params[:place])
  end

  def edit
    respond_with @place = current_user.places.find(params[:id])
  end

  def update
    @place = current_user.places.find(params[:id])
    respond_with @place.update_attributes(params[:place])
  end

  def destroy
    @place = current_user.places.find(params[:id])
    @place.destroy
    respond_with @place
  end

  private

  def only_for_owners
    raise ActiveRecord::RecordNotFound unless current_user.owner?
  end

end
