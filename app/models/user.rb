class User < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :liked_events, through: :likes, source: :event

  has_secure_password

  validates :name, presence: true
  validates :email, format: {with: /\S+@\S+/}, uniqueness: {case_sensitive: false}

end
