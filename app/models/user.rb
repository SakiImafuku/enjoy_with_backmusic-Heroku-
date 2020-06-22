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
  has_many :favorites, dependent: :destroy
  has_many :fav_musicposts, through: :favorites, source: :musicpost

  has_one_attached :avatar

  validates :name, presence: true, length: { maximum: 50 }
  validates :self_introduction, length: { maximum: 300 }
  validates :avatar,
            content_type: {
              in: ['image/jpeg', 'image/gif', 'image/png'],
              message: "有効なフォーマットを指定してください。",
            },
            size: {
              less_than: 5.megabytes,
              message: "5MB以下にしてください。",
            }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # デフォルト画像を保存する
  def default_avatar
    avatar.attach(io: File.open('app/assets/images/avatar.png'),
                  filename: 'avatar.png',
                  content_type: 'img/png')
  end

  # 表示用のリサイズ済み画像を返す
  def display_avatar
    avatar.variant(combine_options: { resize: "150x150^", crop: "150x150+0+0", gravity: :center })
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

  # お気に入り登録する
  def favorite(musicpost)
    fav_musicposts << musicpost
  end

  # お気に入りを解除する
  def unfavorite(musicpost)
    favorites.find_by(musicpost_id: musicpost.id).destroy
  end

  # お気に入り登録していたらtrueを返す
  def favorite?(musicpost)
    fav_musicposts.include?(musicpost)
  end
end
