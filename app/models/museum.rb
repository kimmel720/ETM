class Museum < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user

  has_many :exhibitions
end
