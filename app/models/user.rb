class User < ApplicationRecord
  before_save :downcase

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :username, presence: true, length: { maximum: 25 },
                       uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 7 }

  has_secure_password


  def self.digest(token)
    BCrypt::Password.create(token)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def create_remember_digest(remember_token)
    remember_digest = User.digest(remember_token)
    update_attribute(:remember_digest, remember_digest)
  end

  def validate_token(token)
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private
    def downcase
      self.username.downcase!
      self.email.downcase!
    end  
end
