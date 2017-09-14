class ConsumerRequest < ApplicationRecord
  belongs_to :user
  has_many :artist_services


  # def confirmed?
  #   status == 'confirmed'
  # end

  # def generate_transaction
  #   if confirmed?
  #     Transaction.new(self.id)
  #   end
  # end
end

