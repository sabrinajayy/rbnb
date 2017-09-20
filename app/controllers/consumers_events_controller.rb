class ConsumersEventsController < ApplicationController
  before_action :set_consumer_event, only: [:show, :destroy, :update, :edit]

  def show
    @consumer_event = ConsumerEvent.find(params[:id])
    @artist_requests = ArtistRequest.where(consumer_event: @consumer_event)
  end

  def index
  end

  def search
    @artist = Artist.find_by(user: current_user)

    @consumer_events = ConsumerEvent.near(@artist.latitude, @artist.longitude)
  end

  def new
    @consumer_event = ConsumerEvent.new
  end

  def create
    @consumer = current_user.consumer
    @consumer_event = ConsumerEvent.new(consumer_event_params)
    @consumer_event.user = current_user
    if @consumer_event.save
      redirect_to consumer_consumers_event_path(@consumer, @consumer_event)
    else
      redirect_to new_consumer_consumers_event_path(@consumer)
    end
  end

  def destroy
    @consumer_event.destroy!
    redirect_to consumer_path
  end

  def update
    @consumer_event.update(consumer_event_params)
    redirect_to consumer_consumers_event_path
  end

  def edit
  end

  private
  def set_consumer_event

    @consumer_event = ConsumerEvent.find(params[:id])
  end

  def consumer_event_params
    params.require(:consumer_event).permit(:location, :date, :service, :description, :tags, :budget)
  end
end



