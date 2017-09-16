class ConsumersRequestsController < ApplicationController
  before_action :set_artist, only: [:new, :show, :create]
  before_action :set_consumer_request, only: [:show]

  def index
    # show all bookings
  end

  def show

    @event = ConsumerRequest.find(params[:id])
    # @event_coords = { lat: @event.latitude, lon: @event.longitude }
    if @event.geocoded?
      @hash = Gmaps4rails.build_markers(@event) do |event, marker|
        marker.lat event.latitude
        marker.lng event.longitude
      end
    end
    # raise
  end

  def new

    @consumer_request = ConsumerRequest.new
    @services = ArtistService.where(artist: @artist)

  end

  def create

    consumer_request = ConsumerRequest.new(consumer_request_params)

    consumer_request.user_id = current_user.id

    service = ArtistService.find(params[:consumer_request][:artist_service][:name])

    consumer_request.final_price = service.price
    consumer_request.servicename = service.name

    consumer_request.artist = @artist
    consumer_request.status = 'unconfirmed'
    @consumer = Consumer.find_by(user: current_user)
    if consumer_request.save
      redirect_to artist_consumers_request_path(consumer_request.artist, consumer_request)
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
    params.require(:consumer_request).permit(:artist_service, :date, :time, :address)
  end
end
