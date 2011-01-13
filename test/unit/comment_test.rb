require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @comment = comments(:bamboo_comment)
  end
  test "comment must contain a comment" do
    @comment.comment = nil
    assert !@comment.save
  end

  test "comment must belong to a user" do
    @comment.user = nil
    assert !@comment.save
  end

  test "comment must belong to a restaurant" do
    @comment.restaurant = nil
    assert !@comment.save
  end
end
