class Exhibition < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user
  belongs_to :museum

  has_many :rooms
end
