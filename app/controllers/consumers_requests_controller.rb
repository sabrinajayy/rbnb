class ConsumersRequestsController < ApplicationController
  before_action :set_artist, only: [:new, :show, :create, :destroy, :update]
  before_action :set_consumer_request, only: [:show, :destroy, :update]

  def show

    @event = ConsumerRequest.find(params[:id])
    @messages = Message.where(consumer_request: @event)
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

    @consumer_request.destroy!
    if current_user.is_artist?
      redirect_to artist_path(@artist)
    else
      redirect_to consumer_path
    end
  end

  def update
    @consumer_request.status = 'confirmed'
    @consumer_request.save

    TimeBlock.create(artist: @consumer_request.artist, date: @consumer_request.date, consumer_request: @consumer_request, end_date: @consumer_request.date.advance(hours: 1) )

    redirect_to artist_path(@artist)
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
