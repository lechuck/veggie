class CreateBranches < ActiveRecord::Migration
  def self.up
    # remove columns from restaurant
    remove_column :restaurants, :address, :phone, :hours
    
    create_table :branches do |t|        
      t.integer :restaurant_id
      t.string :street
      t.string :city
      t.string :phone
      t.string :hours
      t.string :email

      t.timestamps
    end
  end

  def self.down
    add_column :restaurants, :address, :phone, :hours    
    
    drop_table :branches
  end
end
