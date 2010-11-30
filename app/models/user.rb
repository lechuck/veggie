class User < ActiveRecord::Base
  acts_as_authentic
  has_many :restaurants
  has_many :reviews
  has_many :portions
end
