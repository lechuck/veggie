class Portion < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates_presence_of :name
  
  
end
