class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 10 }

  validates :content, presence: true, length: { minimum: 30 }
end
