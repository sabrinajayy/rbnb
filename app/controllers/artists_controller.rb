class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :index, :show]
  before_action :set_artist, only: [:show, :edit, :update]

  def index
    @artists = Artist.all
  end

  def show
    @date = DateTime.now
    @review = Review.new
    @reviews = Review.where(artist_id: @artist)
    requests = ConsumerRequest.where(artist: @artist)
    @confirmed = requests.select { |request| request.status == 'confirmed' }
    @unconfirmed = requests.select { |request| request.status == 'unconfirmed' }
    unless TimeBlock.where(artist: @artist).empty?
      time_blocks = TimeBlock.where(artist: @artist)
      @time_blocks_by_date = time_blocks.group_by { |i| i.date.to_date}
    end

  end

  def eventsearch
    @events = ConsumerEvent.all
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.user = current_user
    prices = [15, 43.50, 87, 33.10, 45, 60.99]
    params[:artist][:artist_services].each do |service|
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

    if params[:artist][:artist_services]
      params[:artist][:artist_services].each do |service|
        ArtistService.create({ name: service, price: prices.sample.to_f, artist: @artist})
      end
    end
    @artist.update(artist_params)
    redirect_to artist_path(@artist)
  end

  def search

    service = params[:category]
    location = params[:location]
    # @location_arr = @location.delete(',').split # where is this used?
    long = params[:longitude]
    lat = params[:latitude]
    begin
      time_range = MakeTimeRange.new(params[:date], params[:time]).call
    rescue
    end

    # by location and date and service (always filled in)
    if !location.empty? && !params[:date].empty?

      # consider iterating over the return of Artist.where, selecting for artist_instance_result.near([lat, long], artist.range)
      # results_by_cat = Artist.where(category: service)
      # results_by_cat_and_location =
      results_by_cat_and_location = Artist.where("category ILIKE ?", service) && Artist.near([lat, long], 10)
      @results = results_by_cat_and_location.reject do |artist|
        CheckArtistClashesForSegment.new(artist, time_range).call
      end

    # by location and service
    elsif !location.empty?
      @results = Artist.where("category ILIKE ?", service) && Artist.near([lat, long], 10)

    # by date and servie
    elsif !params[:date].empty?
      results_by_cat = Artist.where(category: service)
      @results = results_by_cat.reject do |artist|
        CheckArtistClashesForSegment.new(artist, time_range).call
      end

    # by service only
    else
      @results = Artist.where(category: service)
    end


  end

  private
  def set_artist
    @artist = Artist.find(params[:id])
    # may need the below method for edit and update later
    # @artist = Artist.find(current_user.artist.id)
  end

  def artist_params
    params.require(:artist).permit(:first_name, :last_name, :bio, :location, :tags, :travel_range, :instagram_handle, :category, :photo, :photo_cache, {artist_service: []})
  end
end
