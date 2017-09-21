class CheckArtistClashesForSegment
  def initialize(artist, time_query_range)
    @artist = artist
    @time_query_range = time_query_range
  end

  def call
    check_for_clashes(given_time_blocks)
  end

  private
  def given_time_blocks
    TimeBlock.where(artist: @artist)
  end

  def check_for_clashes(given_time_blocks)
    given_time_blocks.any? { |block| @time_query_range.cover? block.date }
  end
end



