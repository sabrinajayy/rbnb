class BlockArtistAvailability
  def initialize(artist, date)
    @artist = artist
    @date = date
  end

  def call
    build_block_for(point_in_calendar)
  end

  private
  def build_build_block_for(point)
    [9,12,18].each { |hour_time| TimeBlock.create(artist: @artist, date: )}
    TimeBlock.create(artist: artist_sarah, date: booking.date, consumer_request: booking)
  end

  def point_in_calendar
    @date
  end


end
