class TimeBlock < ApplicationRecord
  belongs_to :artist
  belongs_to :consumer_request


  def duration
    ((self.end_date - self.date) * 24 * 60 * 60).to_i
  end

  def consumer_name
    self.consumer_request.consumer.first_name
  end

  def pretty_time
    self.date.strftime("%H %M")
  end

end
