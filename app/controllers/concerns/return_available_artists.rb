class ReturnAvailableArtists

  def initialize(params, artist)
    # raise
    @params = params
    @artist = artist
  end

  def call
    time_range = MakeTimeRange.new(@params[:date], @params[:time]).call
    artist_gaps = GiveArtistAvailabilityRanges.new(@artist).call
    filtered_gaps = SelectGapsForGivenDaySegment.new(artist_gaps, time_range).call
    TestArtistAvailability.new(filtered_gaps, @params[:date]).call
  end
end

