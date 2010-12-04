class CreatePortions < ActiveRecord::Migration
  def self.up
    create_table :portions do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.string :name
      t.text :veganmod
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end

  def self.down
    drop_table :portions
  end
end
