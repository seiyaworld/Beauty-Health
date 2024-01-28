class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  ## フォローする側
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  ## フォローされる側
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower


  has_one_attached :profile_image

  def get_profile_image(height,width)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default.jpg', content_type: 'image/jpg')
    end
    profile_image.variant(resize_to_limit: [height,width]).processed
  end

  def follow(user)
	  relationships.create(followed_id: user.id)
  end

  def unfollow(user)
	  relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
	  followings.include?(user)
  end

  def self.searcing(search,word)
    if search == "perfect"
      @users = User.where("name LIKE?","#{word}")
    elsif search == "forward"
      @users = User.where("name LIKE?","#{word}%")
    elsif search == "backward"
      @users = User.where("name LIKE?","%#{word}")
    elsif search == "partial"
      @users = User.where("name LIKE?","%#{word}%")
    else
      @users = User.all
    end
  end
end
