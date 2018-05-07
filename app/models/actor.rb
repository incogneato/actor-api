class Actor < ApplicationRecord
  has_one :most_known_work

  validates_presence_of :name, :photo_url, :profile_url, :birth_day, :birth_month
end
