class Room < ApplicationRecord
  belongs_to :user
  has_many_attached :images,  dependent: :destroy 
  has_many :reservations,  dependent: :destroy 
  geocoded_by :address
  has_many :reviews,  dependent: :destroy 

  validates :images, presence: true

  def validate_image?
    if images.nil?
      false 
    else
      true
    end
  end

  validates_associated :images, presence: true

  def average_rating 
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
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

end
