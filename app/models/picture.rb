# frozen_string_literal: true

class Picture < ApplicationRecord
  validates :photo, presence: true

  mount_uploader :photo, ImageUploader
end
