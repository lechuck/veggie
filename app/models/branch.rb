class Branch < ActiveRecord::Base
  belongs_to :restaurant

  #validates_presence_of :restaurant, :street, :city
  validates_presence_of :street, :city
end
