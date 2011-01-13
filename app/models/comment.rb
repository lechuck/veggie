class Comment < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  validates_presence_of :comment, :restaurant, :user
  delegate :username, :to => :user
  delegate :restaurant, :to => :restaurant, :prefix => true

 # overrides default accessor
  def comment
    return 'Kommentti on poistettu.' if deleted
    read_attribute(:comment)
  end
end
