class Post < ApplicationRecord
  # Associations
  belongs_to :user

  # Scopes
  default_scope -> { order(created_at: :desc) }
  scope :published, -> { where('published=?', true) }

  # Validations
  validates :title, presence: true,
                    length: { maximum: 50 }

  validates :body, presence: true
end
