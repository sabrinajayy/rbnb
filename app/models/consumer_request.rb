class ConsumerRequest < ApplicationRecord
  belongs_to :artist
  has_one :review
  has_one :time_block

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

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

