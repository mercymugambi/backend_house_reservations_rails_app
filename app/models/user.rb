class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :houses, foreign_key: 'admin_user_id'
  has_many :reservations
  scope :admins, -> { where(admin: true) }

  validates :name, :email, :password, presence: true
end
