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

  def formatted_date(date, type)
    if date.year == Date.today.year
      date.to_fs(:stamp_this_year)
    else
      type == list ? date.to_fs(:stamp_list_old) : date.to_fs(:stamp_show_old)
    end
  end
end
