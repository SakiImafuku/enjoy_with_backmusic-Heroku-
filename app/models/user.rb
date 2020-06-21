class User < ApplicationRecord

  has_many :musicposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
            foreign_key: "follower_id",
            dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
            foreign_key: "followed_id",
            dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :avatar

  validates :name, presence: true, length: { maximum: 50 }
  validates :self_introduction, length: { maximum: 300 }
  validates :avatar, content_type: { in: %w[image/jpeg image/gif image/png],
            message: "有効なフォーマットを指定してください。" },
            size: { less_than: 5.megabytes,
            message: "5MB以下にしてください。" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 表示用のリサイズ済み画像を返す
  def display_avatar
    avatar.variant(resize: "150x150!")
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
