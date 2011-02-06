class Portion < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates_presence_of :name, :user, :restaurant
  validate :portion_names_are_unique_within_restaurants
  delegate :name, :to => :restaurant, :prefix => true

  def portion_names_are_unique_within_restaurants
    old_portion = Portion.find_by_restaurant_id_and_name(restaurant, name)
    errors.add(:name, "Ravintolalla ei voi olla kahta samannimistä annosta") if (old_portion && id != old_portion.id)
  end

end
