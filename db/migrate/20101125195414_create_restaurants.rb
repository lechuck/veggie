class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :website
      t.text :info
      t.string :hours

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurants
  end
end
