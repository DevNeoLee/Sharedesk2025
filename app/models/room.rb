class Room < ApplicationRecord
  belongs_to :user
  has_many_attached :images,  dependent: :destroy 
  has_many :reservations,  dependent: :destroy 
  geocoded_by :address
  has_many :reviews,  dependent: :destroy 

  # validates :images, presence: true

  def validate_image?
    if images.nil?
      false 
    else
      true
    end
  end

  # validates_associated :images, presence: true

  def average_rating 
    if reviews.count == 0 
      0 
    else 
      raw_rating = reviews.average(:star)
      # Round to nearest 0.5
      (raw_rating * 2).round / 2.0
    end
  end

  def small_image(image)
    image.variant(resize_to_fill: [80, 80]) 
  end

  def medium_image(image)
    image.variant(resize_to_fill: [300, 300], quality: 2000) 
  end

  def large_image(image)
    image.variant(resize_to_fill: [400, 400]) 
  end

  def default_room
    if avatar.attached?
      avatar
    else 
      'default_avatar.png'
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["active", "address", "bath_room", "capacity", "created_at", "desk_type", "id", "id_value", "is_air", "is_conference", "is_drinks", "is_heating", "is_kitchen", "is_parking", "is_printing", "is_wifi", "latitude", "listing_name", "longitude", "manager_on", "noise_level", "price", "security_level", "space_type", "summary", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "reservations", "reviews"]
  end

end
