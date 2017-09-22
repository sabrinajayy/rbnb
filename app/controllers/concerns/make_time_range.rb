class MakeTimeRange
  def initialize(day, segment)
    @day = day
    @segment = segment
  end

  def call
    range_from(given_segment_for(given_day))

  end

  private
  def given_day

    data = @day.split('-').map { |i| i.to_i }
    DateTime.new(data[0], data[1], data[2])
  end

  def given_segment_for(day)
    case @segment
    when 'morning'
      day.change(hour: 7)
    when 'afternoon'
      day.change(hour: 12)
    when 'evening'
      day.change(hour: 17)
    end
  end

  def range_from(start_point)
    (start_point..start_point.advance(hours: 5))
  end
end
