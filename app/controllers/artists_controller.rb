class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :index, :show]
  before_action :set_artist, only: [:show, :edit, :update]

  def index
    @artists = Artist.all
  end

  def show
    @artist_gallery = ArtistImage.where(artist: @artist)
    @date = DateTime.now
    @review = Review.new
    @reviews = Review.where(artist_id: @artist)
    requests = ConsumerRequest.where(artist: @artist)
    @confirmed = requests.select { |request| request.status == 'confirmed' }
    @unconfirmed = requests.select { |request| request.status == 'unconfirmed' }
    unless TimeBlock.where(artist: @artist).empty?
      time_blocks = TimeBlock.where(artist: @artist)
      @time_blocks_by_date = time_blocks.group_by { |i| i.date.to_date}
    else
      @time_blocks_by_date = {}
    end
    @my_bids = ArtistRequest.where(artist: @artist)
  end

  def eventsearch
    @artist = Artist.find(params[:artist_id])
    @events = ConsumerEvent.all.reverse
    @request = ArtistRequest.new
    @coords = [@artist.latitude, @artist.longitude]

    #map

      @hash = Gmaps4rails.build_markers(@events) do |event, marker|
        if event.geocoded?
          marker.lat event.latitude
          marker.lng event.longitude
          marker.infowindow render_to_string(partial: "shared/map_box", locals: { event: event })
          marker.json({ :id => event.id })
        end
      end
  end

  def new
    @artist = Artist.new
    @artist_image = @artist.artist_images.build
  end

  def create
    @artist = Artist.new(artist_params)

    @artist.rating = 0.0
    @artist.user = current_user
    prices = [15, 43.50, 87, 33.10, 45, 60.99]
    params[:artist][:artist_services].each do |service|
      ArtistService.create({ name: service, price: prices.sample, artist: @artist})
    end

    if @artist.save
      if params[:artist_images]
        params[:artist_images]['image'].each do |i|
          @artist_image = @artist.artist_images.create!(:image => i)
       end
      end
      redirect_to artist_path(@artist)

    else
      render 'artists/new'
    end
  end

  def edit

  end

  def update

    # prices = [15.0, 43.50, 87.99, 33.10, 45.85, 60.99]

    if params[:artist][:artist_services]
      params[:artist][:artist_services].each do |service, price|
        ArtistService.create({ name: service, price: price, artist: @artist})
      end
    end
    @artist.update(artist_params)
    redirect_to artist_path(@artist)
  end

  def search
    service = params[:category]
    location = params[:location]
    long = params[:longitude]
    lat = params[:latitude]

    # consider adding a specific time to the search bar as we can now search by that
    # using ReturnAvailableArtists.new(params, artist).call
    begin
      time_range = MakeTimeRange.new(params[:date], params[:time]).call
    rescue
    end

    # by location and date and service (always filled in)
    if !location.empty? && !params[:date].empty?
      results_by_cat = Artist.where(category: service)
      results_by_cat_and_location = SearchArtistByLocation.new(results_by_cat, lat, long).call
      @results = results_by_cat_and_location.reject do |artist|
        CheckArtistClashesForSegment.new(artist, time_range).call
      end

    elsif !location.empty?
      results_by_cat = Artist.where(category: service)
      results_by_cat_and_location = SearchArtistByLocation.new(results_by_cat, lat, long).call
      @results = results_by_cat_and_location

    # by date and service
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

  def reserve_day

    # TimeBlock.new(date:, end_date:, artist:).save(:validate => false)
  end

  private
  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:first_name, :last_name, :bio, :location, :tags, :travel_range, :instagram_handle, :category, :photo, :photo_cache, {artist_service: []})
  end
end

# , artist_images_attributes: [:id, :artist_id, :image, :image_cache]
