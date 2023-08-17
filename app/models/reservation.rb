class Reservation < ApplicationRecord
end

belongs_to user
has_one house