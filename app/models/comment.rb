class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :musicpost
  has_many :notifications, dependent: :destroy
  validates :user_id, presence: true
  validates :musicpost_id, presence: true
  validates :content, presence: true, length: { maximum: 300 }

  scope :latest, -> { order(created_at: :desc) }
end
