require_relative 'test_helper'

class TestOldPosts < MiniTest::Unit::TestCase
  include TestHelper

  OLD_POSTS = {
    "/2012/metrics-driven-development/" => "There exists loads of tools"
  }

  def setup
    start_server
  end

  def teardown
    stop_server
  end

  def test_old_posts_are_available
    OLD_POSTS.each do |url, content|
      assert_match(get_page(url), content)
    end
  end
end
