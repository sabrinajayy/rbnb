class Artist < ApplicationRecord
  # CATEGORY = [['Hair', 'hair'], ['Makeup', 'makeup'], ['Hair and Makeup', 'both']]
  belongs_to :user
  has_many :certifications
  has_many :artist_services
  has_many :artist_images
  has_many :messages, through: :artist_requests
  has_many :reviews

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :location, presence: true
  # validates :tags, presence: true
  # mount_uploader :photo, PhotoUploader
end
