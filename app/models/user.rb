class User < ActiveRecord::Base
  acts_as_authentic
  has_many :restaurants
  has_many :ratings
  has_many :portions
  has_many :comments
  has_many :likes
  
  has_many :liked_restaurants, :through => :likes, :source => :restaurant
  has_many :commented_restaurants, :through => :comments, :source => :restaurant
  has_many :rated_restaurants, :through => :ratings, :source => :restaurant
  
end
