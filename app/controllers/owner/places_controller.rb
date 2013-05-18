class Owner::PlacesController < Owner::BaseController

  def index
    respond_with @places = current_user.places
  end

  def new
    respond_with place
  end

  def create
    place.save
    respond_with place, location: owner_places_path
  end

  def edit
    respond_with place
  end

  def update
    place.update_attributes(params[:place])
    respond_with place, location: owner_places_path
  end

  def destroy
    place.destroy
    respond_with place, location: owner_places_path
  end

  private

  def place
    @place ||= build_resource current_user.places, :place
  end

end
