class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :musicpost
  validates :user_id, presence: true
  validates :musicpost_id, presence: true
  validates :content, length: { maximum: 300 }
end
