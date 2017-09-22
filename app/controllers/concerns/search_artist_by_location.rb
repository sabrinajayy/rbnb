
class SearchArtistByLocation
  def initialize(results, lat, long)
    @lat = lat
    @long = long
    @results = results
  end

  def call
    selected_by_proximity
  end

  private
  def selected_by_proximity
    @results.select do |artist|
      Geocoder::Calculations.distance_between([@lat, @long],
                                              [artist.latitude, artist.longitude]
                                              ) <= artist.travel_range
    end
  end
end
