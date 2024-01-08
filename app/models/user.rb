class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         
  has_many :posts, dependent: :destroy
  has_one_attached :profile_image       
  
  def get_profile_image(height,width)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default.jpg', content_type: 'image/jpg')
    end
    profile_image.variant(resize_to_limit: [height,width]).processed
  end
end
