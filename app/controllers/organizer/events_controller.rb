class Organizer::EventsController < Organizer::BaseController

  def index
    respond_with @events = current_user.events
  end

  def new
    respond_with event
  end

  def create
    event.save
    respond_with event, location: organizer_events_path
  end

  def edit
    respond_with event
  end

  def update
    event.update_attributes(params[:event])
    respond_with event, location: organizer_events_path
  end

  def destroy
    event.destroy
    respond_with event, location: organizer_events_path
  end

  private

  def event
    @event ||= build_resource current_user.events, :event
  end

end