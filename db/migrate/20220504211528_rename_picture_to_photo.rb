# frozen_string_literal: true

class RenamePictureToPhoto < ActiveRecord::Migration[7.0]
  def change
    rename_column :pictures, :picture, :photo
  end
end
