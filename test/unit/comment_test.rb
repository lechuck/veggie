require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @comment = comments(:bamboo_comment)
  end
  test "comment must contain a comment" do
    @comment.comment = nil
    assert !@comment.save
  end
end
