class Consumer < ApplicationRecord
  belongs_to :user

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # validates :name, presence: true
  # validates :city, presence: true
  # validates :phone_number, presence: true

end
