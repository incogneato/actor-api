class MostKnownWork < ApplicationRecord
  belongs_to :actor

  validates_presence_of :title, :url, :rating, :director, :actor_id
end
