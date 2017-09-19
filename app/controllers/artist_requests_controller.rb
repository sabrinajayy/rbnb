class ArtistRequestsController < ApplicationController
  before_action :set_artist_request only: [:update, :show]

  def show

  end

  def new
    @artist_request = ArtistRequest.new
  end

  def create
    ArtistRequest.new(artist_request_params)
  end

  def update

    ConsumerRequest.new()
    @artist_request.destroy!
  end

  private
  def artist_request_params
    params.require(:artist_request).allow(:offer_price)
  end

  def set_artist_request
    @artist_request.find(params[:id])
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
