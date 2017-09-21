
class SelectGapsForGivenDaySegment
  # takes all availability segments and filters them to correspond with
  def initialize(availability_segments, day_segment)
    @day_segment = day_segment
    @availability_segments = availability_segments
  end

  def call
    filtered_segments
  end

  private
  def filtered_segments
    @availability_segments.select { |segment| day_segment.cover? segment.first }
  end

end
