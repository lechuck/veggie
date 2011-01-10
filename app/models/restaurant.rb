class Restaurant < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  has_many :portions, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :branches, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  has_many :likes, :dependent => :delete_all
  has_many :users, :through => :likes
  # has_many :users, :through => :comments
  
  validates :name, :info, :presence => true
  
  def self.top(attribute, limit)
     # creates [restaurant, rating] ordered hash
     all_restaurants = Review.group(:restaurant).average(attribute).sort {|a,b| -1*(a[1] <=> b[1])}
     all_restaurants[0..limit-1]
  end

  def like(user)
    unless users.include?(user)
      like = Like.new :user => user
      likes << like
    end
  end

end
