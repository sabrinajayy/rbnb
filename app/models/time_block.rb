class TimeBlock < ApplicationRecord
  belongs_to :artist
  belongs_to :consumer_request


  def duration
    ((self.end_date - self.date) * 24 * 60 * 60).to_i
  end

  def consumer_name
    if self.consumer_request
      self.consumer_request.consumer.first_name
    else
      'Day Blocked'
    end
  end

  def pretty_time
    self.date.strftime("%H %M")
  end

  def all_day?
    self.category == 'all day'
  end

  def consumer
    self.consumer_request.consumer
  end

end
