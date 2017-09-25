class Message < ApplicationRecord
  belongs_to :user
  belongs_to :consumer_request
end
