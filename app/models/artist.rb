class Artist < ApplicationRecord
  belongs_to :user
  has_many :certifications
  has_many :artist_services
  has_many :artist_images
  has_many :messages through: :artist_requests

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :location, presence: true
  validates :tags, presence: true

end
