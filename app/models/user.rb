class User < ActiveRecord::Base
  acts_as_authentic
  has_many :restaurants
  has_many :reviews
  has_many :portions
  has_many :comments
  
  has_many :likes
  has_many :restaurants, :through => :likes
  has_many :restaurants, :through => :comments
  
end
