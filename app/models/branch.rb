class Branch < ActiveRecord::Base
  belongs_to :restaurant

  validates_presence_of :street, :city
end
