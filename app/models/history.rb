class History < ApplicationRecord
  belongs_to :user
  belongs_to :musicpost
  validates :user_id, presence: true
  validates :musicpost_id, presence: true
end
