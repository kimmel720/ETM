class Exhibition < ActiveRecord::Base
  belongs_to :museum
  has_many :rooms
end
