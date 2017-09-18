class ArtistAvailibility
  def initialize(artist, time_query)
    @artist = artist
    @time_query = time_query
  end

  def call
    check_for_clashes(given_availibilty)
  end

  private
  def given_availibilty
    TimeBlock.where(artist: @artist)
  end

  def check_for_clashes(availibility)
    !availibility.any? do |timeblock|
      (timeblock - 1.hours) < @time_query < (timeblock + 1.hours)
    end
  end
end
# ArtistAvailibility.new(@artist, query).call => boolean

