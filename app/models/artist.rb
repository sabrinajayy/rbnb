class Artist < ApplicationRecord
  # CATEGORY = [['Hair', 'hair'], ['Makeup', 'makeup'], ['Hair and Makeup', 'both']]
  belongs_to :user
  has_many :certifications
  has_many :artist_services
  has_many :artist_images
  has_many :messages, through: :artist_requests

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :location, presence: true
  # validates :tags, presence: true
  mount_uploader :photo, PhotoUploader
end
