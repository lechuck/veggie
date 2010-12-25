class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :comment
      t.integer :positive_votes
      t.integer :negative_votes
      t.integer :user_id
      t.integer :restaurant_id
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
