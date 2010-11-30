class Restaurant < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  has_many :portions
  has_many :reviews

  validates :name, :address, :info, :presence => true
  
end
