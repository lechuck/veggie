class Restaurant < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  has_many :portions, :dependent => :delete_all
  has_many :reviews, :dependent => :delete_all
  has_many :branches, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all
  
  has_many :likes, :dependent => :delete_all
  has_many :users, :through => :likes
  has_many :users, :through => :comments
  
  validates :name, :info, :presence => true
  
  def self.top5(attribute)
    # creates [restaurant, rating] array sorted by rating
    all_restaurants = Review.group(:restaurant).average(attribute).sort {|a,b| -1*(a[1] <=> b[1])}
    # limit to only 5 best restaurants
    top5 = all_restaurants[0..4]
  end
  
end
