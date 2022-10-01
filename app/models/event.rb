class Event < ApplicationRecord
  # callbacks
  before_save :set_slug 

  has_many :likes, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :categorizations , dependent: :destroy
  has_many :categories, through: :categorizations

    validates  :location, presence: true 
    validates :name, uniqueness: true ,presence: true 
    validates :description, length: { minimum: 25 }
  
    validates :price, numericality: { greater_than_or_equal_to: 0 }
  
    validates :capacity, numericality:
                         { only_integer: true, greater_than: 0 }
  
    validates :image_file_name, format: {
      with: /\w+\.(jpg|png)\z/i,
      message: "must be a JPG or PNG image"
    }

 
  scope :upcoming,  -> {where("starts_at > ?", Time.now).order("starts_at")}
  scope :free,  -> {upcoming.where(price: 0).order("name")}
  scope :recent, ->(max=3) {past.limit(max)}
  scope :past,  -> {where("starts_at < ?", Time.now).order("starts_at")}

    
  
    def free?
      price.blank? || price.zero?
    end

    def sold_out?
      (capacity - registrations.size).zero?
    end

    def to_param
      slug
    end
  private
  def set_slug
    self.slug = name.parameterize
  end
  
  end
  