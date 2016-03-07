class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password

  # admin ownership
  has_many :museums
  has_many :exhibitions, through: :museums
end
