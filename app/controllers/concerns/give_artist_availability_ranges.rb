class GiveArtistAvailabilityRanges
  def initialize(artist)
    @artist = artist
    # @date = date
  end

  def call
    gaps_between(strung_together(time_blocks))
  end

  private
  def time_blocks
    TimeBlock.where(artist: @artist)
  end

  def strung_together(time_blocks)
    time_blocks.map { |tb| [tb.date, tb.end_date] }.sort_by { |t| t[1] }
  end

  def gaps_between(sequential_time_blocks)
    start_times = sequential_time_blocks.map { |tb| tb[0] }
    start_times.delete_at(0)
    finish_times = sequential_time_blocks.map { |tb| tb[1] }
    finish_times.delete_at(-1)
    gaps = []
    finish_times.each_with_index { |j,i| gaps.push((j..start_times[i])) }
    gaps
  end
end









