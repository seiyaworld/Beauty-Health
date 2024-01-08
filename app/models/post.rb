class Post < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_one_attached :image
  
  
  validates :title, presence: true
  validates :body, presence: true
  
  
  
  def get_post_image(height,width)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/sample-post.jpg')
      image.attach(io: File.open(file_path), filename: 'default-post.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_limit: [height,width]).processed
  end
  
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  
end
