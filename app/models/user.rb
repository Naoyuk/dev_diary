class User < ApplicationRecord
  # Associations

  # Callback
  before_save :downcase_email

  # Validations
  validates :name, presence: true,
                   length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true,
                       length: { minimum: 6 }
  validates :password_confirmation, presence: true,
                       length: { minimum: 6 }

  # Secure password
  has_secure_password

  # methods
  private

    def downcase_email
      email.downcase!
    end
end
