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
    logged_in? ? zone = current_user.time_zone : 'UTC'
    local_time = date.in_time_zone(zone)

    if local_time.year == Date.today.year
      local_time.to_fs(:stamp_this_year)
    else
      type == list ? local_time.to_fs(:stamp_list_old) : local_time.to_fs(:stamp_show_old)
    end
  end
end
