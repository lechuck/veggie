class Restaurant < ActiveRecord::Base

  acts_as_taggable
  
  belongs_to :user
  
  has_many :portions, :dependent => :destroy
  has_many :branches, :dependent => :destroy

  has_many :ratings, :dependent => :destroy
  has_many :raters, :through => :ratings, :source => :user
  
  has_many :comments, :dependent => :destroy
  has_many :commenters, :through => :comments, :source => :user
  
  has_many :likes, :dependent => :delete_all
  has_many :fans, :through => :likes, :source => :user
  
  validates_presence_of :name, :info, :user

  delegate :username, :to => :user

  #scope :recent, order('created_at DESC')

  # returns list of best restaurants by attribute
  def self.top_by_attribute(attribute, limit)
    # return an array of restaurant objects with rating attribute
    Restaurant.find_by_sql ["SELECT restaurants.*, AVG(ratings.?) AS rating
    FROM ratings, restaurants WHERE restaurants.id = ratings.restaurant_id
    GROUP BY restaurant_id ORDER BY rating DESC LIMIT ?", attribute, limit]
  end
# returns list of top restaurants by overall rating
  def self.top_by_average_rating(limit)
    Restaurant.find_by_sql ["SELECT restaurants.*, (AVG(food)+AVG(service)+AVG(environment))/3 AS rating
    FROM restaurants, ratings WHERE restaurants.id = ratings.restaurant_id
    GROUP BY restaurant_id ORDER BY rating DESC LIMIT ?", limit]
  end

  def self.last_added(limit)
    restaurants = Restaurant.order('created_at DESC').limit(limit)
  end

  # returns list of most rated restaurant in after given time
  def self.most_rated_in_n_days(n, limit)
    Restaurant.find_by_sql ["SELECT restaurants.*, COUNT(*) AS count_all
    FROM restaurants INNER JOIN ratings ON ratings.restaurant_id = restaurants.id
    WHERE (ratings.created_at >= ?) GROUP BY restaurant_id ORDER BY count_all DESC
    LIMIT ?", n, limit]

  end

  def like(user)
    unless fans.include?(user)
      like = Like.new :user => user
      likes << like
    end
  end

  def average_rating_for(attribute)
    Rating.where(:restaurant_id => self).average(attribute)
  end

  def average_rating
    return 0 if ratings.empty?
    value = 0
    total = 0
    self.ratings.each do |rating|
      value = value + rating.sum_value
      total = total + rating.dimensions
    end
    value.to_f / total.to_f
  end

  # method to get a phone number for a restaurant
  # TODO: what will be the phone number in case of multiple branches
  def phone
    branches[0].phone
  end

  def address
    branches[0].street
  end

  def add_tags(tags)
    tag_list << tags.split(',')
  end

  def tag_list
  
  end
  

end
