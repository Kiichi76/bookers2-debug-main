class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :followers, class_name: "Relationships", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationships", foreign_key: "followed_id", dependent: :destroy

  has_many :follower_user, through: :followers, source: :followed
  has_many :followed_user, through: :followeds, source: :follower

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def follow(user)
    followers.create(followed_id: user.id)
  end
  
  def unfollow(user)
    followers.find_by(followed_id: user.id).destroy 
  end

  def following(user)
    follower_user.include?(user)
  end
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
