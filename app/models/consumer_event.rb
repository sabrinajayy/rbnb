class ConsumerEvent < ApplicationRecord
  belongs_to :user
  has_many :artist_requests

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  # def confirmed?
  #   status == 'confirmed'
  # end

  # def generate_transaction
  #   if confirmed?
  #     Transaction.new(self.id)
  #   end
  # end

  def geocoded?
    self.latitude && self.longitude
  end

  def is_past?
    self.date < Time.now
  end

end
