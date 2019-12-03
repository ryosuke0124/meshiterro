class PostImage < ApplicationRecord

  belongs_to :user
  attachment :image # ここを追加（_idは含めません）
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :shop_name, presence: true
  validates :image, presence: true
  def favorited_by?(user)
     favorites.where(user_id: user.id).exists?
  end

  def create
  @post_image = PostImage.new(post_image_params)
  @post_image.user_id = current_user.id
  if @post_image.save
  redirect_to post_images_path
  else
  render :new
  end
 end
end
