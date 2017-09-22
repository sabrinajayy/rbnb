class TestArtistAvailability
  # takes artist availability ranges and checks that a given appointment falls within them
  # allowing for a 30 minute travel window either side of the appointment
  def initialize(gaps, request)
    @gaps = gaps

    data = request.split('-').map { |i| i.to_i }
    @request_start = DateTime.new(data[0], data[1], data[2])
    @request_finish = @request_start.advance(hours: 1)
  end

  def call
    space_in_gaps?
  end

  private
  def space_in_gaps?
    @gaps.any? do |segment|
      (segment.cover? @request_start.advance(minutes: -30)) && (segment.cover? @request_finish.advance(minutes: 30))
    end
  end

  def after_last_block?
  end
end
