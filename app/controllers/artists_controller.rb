class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :index, :show]
  before_action :set_artist, only: [ :edit, :update]

  def index
    # all artists
    @artists = Artist.all
  end

  def show
    # single artist profile
    @artist = (current_user && current_user.is_artist?) ? Artist.find(current_user.artist.id) : Artist.find(params[:id])

    @requests = ConsumerRequest.where(artist: @artist)
    # if current_user == @artist.user
    #   render partial: 'shared/artist_private_profile'
    # else
    #   render partial: 'shared/artist_public_profile'
    # end
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
    # may need the below method for edit and update later
    # @artist = Artist.find(current_user.artist.id)
  end

  def artist_params
    params.require(:artist).permit(:first_name, :last_name, :location, :tags, :travel_range, :instagram_handle, :category, :photo, :photo_cache)
  end


end
