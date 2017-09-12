class ConsumersRequestsController < ApplicationController
  before_action :set_artist, only: [:show, :new]

  def index
    # show all bookings
  end

  def show
  end

  def new
    @consumer_request = ConsumerRequest.new
  end

  def create
    user = current_user
    consumer_request = ConsumerRequest.new(consumer_request_params)
    consumer_request.user = user
    @consumer = Consumer.find_by(user: user)

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
    params.require(:consumer_request).permit(:base_price, :fees, :final_price, :status)
  end
end
