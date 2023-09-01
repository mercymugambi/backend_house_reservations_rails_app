class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :house
end

# With these associations, a user can have multiple reservations,
# and each reservation is linked to a specific house.
# Only one user can reserve a particular house, as each reservation
# is associated with both a user and a house.
