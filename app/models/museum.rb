class Museum < ActiveRecord::Base
  belongs_to :user
  
  has_many :exhibitions
end
