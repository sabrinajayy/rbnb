class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :index, :show]
  before_action :set_artist, only: [:show, :edit, :update]

  def index
    # all artists
    @artists = Artist.all
  end

  def show
    # single artist profile
    @requests = ConsumerRequest.where(artist: @artist)
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to artist_path(@artist)
    else
      render 'artists/new'
    end
  end

  def edit
  end

  def update
    @artist.update(artist_params)
    redirect_to artist_path(@artist)
  end

  def search
    # filtered artists results

    @service = params[:category]
    @results = Artist.where(category: @service)
  end

  private
    # Use callbacks to share common setup or constraints between actions.

 def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:first_name, :last_name, :location, :tags, :travel_range, :instagram_handle, :category)
  end


end
