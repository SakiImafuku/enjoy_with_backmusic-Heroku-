class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :musicpost
  validates :user_id, presence: true
  validates :musicpost_id, presence: true
  validates :memo, presence: true, length: { maximum: 1000 }
end
