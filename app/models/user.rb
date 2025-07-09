class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true, length: { maximum: 35}

  has_many :rooms 
  has_many :reservations
  has_many :reviews
  
  has_one_attached :avatar # Works like a file belonging to the user

  def default_avatar
    if avatar.attached?
      avatar
    else 
      'default_avatar.png'
    end
  end

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid = auth.uid
      user.name = auth.info.email.split('@')[0]
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "email", "id", "id_value", "name", "phone_number", "provider", "uid", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["rooms", "reservations", "reviews"]
  end

end
