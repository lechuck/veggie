class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.integer :food
      t.integer :service
      t.integer :environment

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
