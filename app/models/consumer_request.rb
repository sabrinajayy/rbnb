class ConsumerRequest < ApplicationRecord
  belongs_to :artist
  has_many :messages
  has_one :time_block
  has_one :review, dependent: :destroy


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

  def consumer
    Consumer.find_by(user_id: self.user_id)
  end

end

