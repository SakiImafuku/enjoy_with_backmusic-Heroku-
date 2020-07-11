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

  def taxons_filter(taxonomy_name)
    taxonomy = Taxonomy.find_by(name: taxonomy_name)
    taxons.find_by(taxonomy_id: taxonomy.id)
  end

  def self.following_musicposts(user)
    where(user_id: user.following.ids)
  end

  def self.history_musicposts(user)
    where(id: user.history_musicposts.ids)
  end
end
