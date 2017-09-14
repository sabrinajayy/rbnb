class ConsumerRequest < ApplicationRecord
  belongs_to :artist

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
end

