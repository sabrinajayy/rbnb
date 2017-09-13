class ConsumersRequestsController < ApplicationController
  before_action :set_artist, only: [:show, :new]

  def index
    # show all bookings
  end

  def show
  end

  def new
    @consumer_request = ConsumerRequest.new
    @services = ArtistService.where(artist: @artist)
  end

  def create
    consumer_request = ConsumerRequest.new

    user = current_user
    consumer_request.user = user

    service = ArtistService.find(consumer_request_params[:service])
    consumer_request.final_price = service.price

    consumer_request.status = 'unconfirmed'
    consumer = Consumer.find_by(user: user)

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

  def consumer_request_params
    params.require(:consumer_request).permit(:service)
  end
end
