class Musicpost < ApplicationRecord
  belongs_to :user
  has_many :classifications

  default_scope -> { self.order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :overview, length: { maximum: 140 }
end
