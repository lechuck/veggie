class CreateRestaurantImages < ActiveRecord::Migration
  def self.up
    create_table :restaurant_images do |t|
      t.string :caption
      t.integer :restaurant_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurant_images
  end
end
