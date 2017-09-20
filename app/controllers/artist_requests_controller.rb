class ArtistRequestsController < ApplicationController
  before_action :set_artist_request, only: [:update, :show, :accept, :decline]

  def show

  end

  def new
    @artist_request = ArtistRequest.new
  end

  def create
    artist_request = ArtistRequest.new(artist_request_params)
    artist_request.consumer_event = ConsumerEvent.find(params[:consumer_event_id])
    artist_request.artist = Artist.find(params[:artist_id])
    if artist_request.save
      flash[:notice] = 'thank you for your moneeeeeeeeeeaaaaay'

    else
      flash[:notice] = 'boring boring'
    end
    redirect_to :back

  end

  def accept
    event = @artist_request.consumer_event
    @artist_request.update(status: 'accepted')
    ConsumerRequest.create(final_price: @artist_request.offer_price,
                           user_id: event.user.id,
                           latitude: event.latitude,
                           longitude: event.longitude,
                           date: event.date,
                           address: event.location,
                           servicename: event.service,
                           artist: @artist_request.artist,
                           status: 'confirmed')

    redirect_to :back

  end

  def decline
    @artist_request.update(status: 'declined')
    redirect_to :back
  end



  def update
    ConsumerRequest.create()
    @artist_request.update(status: 'declined')
    ConsumerEvent.find().destroy!
  end

  private
  def artist_request_params
    params.require(:artist_request).permit(:offer_price, :message)
  end

  def set_artist_request
    @artist_request = ArtistRequest.find(params[:id])
  end
end
  # create_table "artist_requests", force: :cascade do |t|
  #   t.float    "offer_price"
  #   t.integer  "consumer_event_id"
  #   t.integer  "artist_id"
  #   t.datetime "created_at",        null: false
  #   t.datetime "updated_at",        null: false
  #   t.index ["artist_id"], name: "index_artist_requests_on_artist_id", using: :btree
  #   t.index ["consumer_event_id"], name: "index_artist_requests_on_consumer_event_id", using: :btree
  # end
