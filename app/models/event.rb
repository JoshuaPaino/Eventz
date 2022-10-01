class Event < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :likers, through: :likes, source: :user

    validates :name, :location, presence: true
  
    validates :description, length: { minimum: 25 }
  
    validates :price, numericality: { greater_than_or_equal_to: 0 }
  
    validates :capacity, numericality:
                         { only_integer: true, greater_than: 0 }
  
    validates :image_file_name, format: {
      with: /\w+\.(jpg|png)\z/i,
      message: "must be a JPG or PNG image"
    }
  
    def self.upcoming
      where("starts_at > ?", Time.now).order("starts_at")
    end
  
    def free?
      price.blank? || price.zero?
    end

    def sold_out?
      (capacity - registrations.size).zero?
    end
  
  
  end
  