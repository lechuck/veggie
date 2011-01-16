class RemoveVotesFromComments < ActiveRecord::Migration
  def self.up
    remove_column :comments, :positive_votes
    remove_column :comments, :negative_votes

  end

  def self.down
    add_column :comments, :positive_votes, :integer
    add_column :comments, :negative_votes, :integer

  end
end
