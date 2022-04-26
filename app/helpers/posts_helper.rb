# frozen_string_literal

module PostsHelper
  def is_published?(post)
    post.published
  end
end
