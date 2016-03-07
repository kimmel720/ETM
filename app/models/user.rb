class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password

  # admin ownership
  has_one :museum
  has_many :exhibitions, through: :museum
end
