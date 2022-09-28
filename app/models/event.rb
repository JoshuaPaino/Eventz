class Event < ApplicationRecord
    # validaitions rules
    validates :name, :location, presence: true

    validates :description, length: {minimum:25}
    validates :price, numericality: {greather_than_or_equal_to: 0}
    validates :capacity, numericality: 
                        {only_integer: true, greather_than: 0}
    validates :image_file_name, format: {
        with: /\w+\.(jpg|png)\z/i,
        message: "must be a JPG or PNG image"
    }
    # class methods
    def self.upcoming
        Event.where("starts_at > ?", Time.now).order("starts_at")
    end

    # logic
    def free?
        price.blank? || price.zero?
    end

    
end
