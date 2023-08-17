class Reservation < ApplicationRecord
  belongs_to :user
  has_one :house
end
