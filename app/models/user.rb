class User < ApplicationRecord
  # Userインスタンスと記憶トークンを紐付けるための仮想属性
  attr_accessor :remember_token

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

  # User class methods
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # User instance methods
  # 記憶トークンをUserインスタンスに紐付け、ハッシュ化してremember_digestに保存
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 引数として渡したトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # methods
  private

    def downcase_email
      email.downcase!
    end
end
