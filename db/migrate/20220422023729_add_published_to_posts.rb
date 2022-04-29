# frozen_string_literal: true

class AddPublishedToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :published, :boolean, default: false
  end
end
