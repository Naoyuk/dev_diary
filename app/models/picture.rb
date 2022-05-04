class Picture < ApplicationRecord
  mount_uploader :photo, ImageUploader
end
