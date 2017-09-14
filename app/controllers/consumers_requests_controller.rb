class ConsumersRequestsController < ApplicationController
  before_action :set_artist, only: [:show, :new]
  before_action :set_consumer_request, only: [:show]

  def index
    # show all bookings
  end

  def show
    @event = ConsumerRequest.find(params[:id])
    @event_coords = { lat: @event.latitude, lon: @event.longitude }

    @hash = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end
    @services = ArtistService.where(consumer_request: @consumer_request)
  end

  def new
    @consumer_request = ConsumerRequest.new
    @services = ArtistService.where(artist: @artist)

  end

  def create
    consumer_request = ConsumerRequest.new

    user = current_user
    consumer_request.user = user

    service = ArtistService.find(consumer_request_params[:artist_services])
    service.consumer_request = consumer_request

    consumer_request.final_price = service.price

    consumer_request.status = 'unconfirmed'
    @consumer = Consumer.find_by(user: current_user)

    if consumer_request.save
      redirect_to consumer_path(@consumer)
    else
      redirect_to new_artist_consumers_request_path
    end
  end

  def destroy
  end

  def update
  end

  def edit
  end

  private
  def set_artist
    @artist = Artist.find(params[:artist_id])
  end

  def set_consumer_request
    @consumer_request = ConsumerRequest.find(params[:id])
  end

  def consumer_request_params
    params.require(:consumer_request).permit(:artist_services, :date, :time, :address)
  end
end
