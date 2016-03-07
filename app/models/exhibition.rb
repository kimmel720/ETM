class Exhibition < ActiveRecord::Base
  belongs_to :museum
  belongs_to :user
  has_many :rooms
end
