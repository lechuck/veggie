class Rating < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  delegate :username, :to => :user
  delegate :name, :to => :restaurant, :prefix => true
  delegate :address, :to => :restaurant, :prefix => true

  validates_inclusion_of :food, :environment, :service, :in => 1..5
  validate :user_can_only_rate_a_restaurant_once, :on => :create

  # validation method
  def user_can_only_rate_a_restaurant_once
    errors.add(:restaurant, "Ravintolasta voi tehdä vain yhden arvostelun") if
    Rating.find_by_restaurant_id_and_user_id(restaurant, user)
  end

  def sum_value
    environment + food + service
  end

  # refactor: is it possible to count the number of attributes on a model?
  # is this necessary?
  def dimensions
    3
  end


end