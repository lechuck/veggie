class Rating < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  delegate :username, :to => :user

  def self.rating(attribute, restaurant)
    Rating.where(:restaurant_id => restaurant).average(attribute)
  end

end