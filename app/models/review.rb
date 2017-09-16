class Review < ApplicationRecord
  belongs_to :artist
  belongs_to :user
  belongs_to :consumer_request
  validates :content, length: { minimum: 10 }
end
