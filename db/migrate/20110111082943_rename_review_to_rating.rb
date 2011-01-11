class RenameReviewToRating < ActiveRecord::Migration
  def self.up
    rename_table :reviews, :ratings
  end

  def self.down
    rename_table :ratings, :reviews

  end
end
