class Museum < ActiveRecord::Base
  # join table used to authenticate  
  has_and_belongs_to_many :users
  has_many :exhibitions
end
