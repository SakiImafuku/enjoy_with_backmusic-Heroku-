class Musicpost < ApplicationRecord
  belongs_to :user
  has_many :classifications, dependent: :destroy
  has_many :taxons, through: :classifications
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites
  has_many :comments, dependent: :destroy
  has_many :com_users, through: :comments
  has_many :memos, dependent: :destroy
  has_many :memo_users, through: :memos
  has_many :histories, dependent: :destroy
  has_many :history_users, through: :histories
  has_many :notifications, dependent: :destroy

  has_one_attached :audio
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :overview, length: { maximum: 300 }
  validates :audio, presence: true

  scope :latest, -> { order(created_at: :desc) }
  scope :popular, -> {
    left_outer_joins(:favorites).
      select('musicposts.*, COUNT(favorites.*) AS fav_count').
      group('musicposts.id').
      order(fav_count: :desc)
  }
  scope :history_latest, -> {
    left_outer_joins(:histories).
      order("histories.id DESC")
  }

  # taxonomyで絞り込む
  def taxons_filter(taxonomy_name)
    taxonomy = Taxonomy.find_by(name: taxonomy_name)
    taxons.find_by(taxonomy_id: taxonomy.id)
  end

  # フォロー中ユーザーの投稿id一覧
  def self.following_musicposts(user)
    where(user_id: user.following.ids)
  end

  # 視聴した投稿id一覧
  def self.history_musicposts(user)
    where(id: user.history_musicposts.ids)
  end

  # いいねされた時に通知する
  def create_notification_like(current_user)
    # いいねされていない場合のみ、通知レコードを作成
    unless Notification.find_by(visitor_id: current_user.id, visited_id: user.id, musicpost_id: id, action: 'favorite')
      notification = current_user.active_notifications.new(
        musicpost_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメントした時に通知する
  def create_notification_comment(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(musicpost_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    # 投稿者に通知を送る
    save_notification_comment(current_user, comment_id, user_id)
  end

  # コメントした時にnotificationモデルにレコードを作成する
  def save_notification_comment(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      musicpost_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
