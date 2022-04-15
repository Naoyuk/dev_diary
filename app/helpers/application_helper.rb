# frozen_string_literal: true

module ApplicationHelper
  # ページ名 | DevDiary というタイトルを返す
  def full_title(page_title = '')
    base_title = 'DevDiary'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
