class Restaurant < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  has_many :portions, :dependent => :delete_all
  has_many :reviews, :dependent => :delete_all
  has_many :branches, :dependent => :delete_all
  
  has_many :likes, :dependent => :delete_all
  has_many :users, :through => :likes
  
  validates :name, :info, :presence => true
  
  def self.top5(attribute)
    top = Review.find(:all, :select => 'restaurant_id, avg(food) as foodavg', :order => 'foodavg DESC', :group => 'restaurant_id', :limit => 5)
    restaurants = []
    top.each do |review|
      #review.name = Restaurant.find(review.restaurant_id)
      restaurant = Restaurant.find(review.restaurant_id)
      pair = [restaurant, review.foodavg]
      restaurants << pair
    end
    restaurants
  end
  
end
