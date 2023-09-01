# A house can have many reservations, and each reservation is associated with one user.
# A house belongs to an admin user, and a house can have many reservations.
class House < ApplicationRecord
  belongs_to :admin_user, class_name: 'User'
  has_many :reservations
end
