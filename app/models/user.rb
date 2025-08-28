class User < ApplicationRecord
  has_many :habits, dependent: :destroy
  has_many :communities, through: :habits
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :photo

  # validates :photo,
  #           content_type: [ "image/png", "image/jpg", "image/jpeg" ],
  #           size: { less_than: 2.megabytes, message: "Photo is too large. Maximum size is 5MB." }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
