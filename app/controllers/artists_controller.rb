class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :index, :show]
  before_action :set_artist, only: [:show, :edit, :update]

  def index
    # all artists
    @artists = Artist.all
  end

  def show

    @review = Review.new
    requests = ConsumerRequest.where(artist: @artist)
    @confirmed = requests.select { |request| request.status == 'confirmed' }
    @unconfirmed = requests.select { |request| request.status == 'unconfirmed' }
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    prices = [15, 43.50, 87, 33.10, 45, 60.99]

    params([:artist][:artist_services]).each do |service|
      ArtistService.create({ name: service, price: prices.sample, artist: @artist})
    end

    if @artist.save

      redirect_to artist_path(@artist)
    else
      render 'artists/new'
    end
  end

  def edit
  end

  def update
    # raise
    prices = [15.0, 43.50, 87.99, 33.10, 45.85, 60.99]
    params[:artist][:artist_services].each do |service|
      ArtistService.create({ name: service, price: prices.sample.to_f, artist: @artist})
    end
    @artist.update(artist_params)
    redirect_to artist_path(@artist)
  end

  def search
    # filtered artists results on category and location
    # params[:id] # will be a user id
    @service = params[:category]
    @location = params[:location]
    @location_arr = @location.delete(',').split
    @longitude = params[:longitude]
    @latitude = params[:latitude]

    if !@location.empty?
      # next two lines are equivalent:
      # @results = Artist.where("category ILIKE ?", @service) && Artist.near(@location, 10)
      @results = Artist.where("category ILIKE ?", @service) && Artist.near([@latitude, @longitude], 10)
    else
      @results = Artist.where(category: @service)
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.

 def set_artist

    @artist = Artist.find(params[:id])
    # may need the below method for edit and update later
    # @artist = Artist.find(current_user.artist.id)
  end

  def artist_params
    params.require(:artist).permit(:first_name, :last_name, :location, :tags, :travel_range, :instagram_handle, :category, :photo, :photo_cache, :artist_services)
  end


end
