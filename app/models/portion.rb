class Portion < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates_presence_of :name, :user, :restaurant
  delegate :name, :to => :restaurant, :prefix => true
  
  
end
