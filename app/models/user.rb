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

  private
    def downcase
      self.username.downcase!
      self.email.downcase!
    end
end
