class Restaurant < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  has_many :portions
  has_many :reviews
  
  has_many :likes
  has_many :users, :through => :likes
  
  validates :name, :address, :info, :presence => true
  
end
