class Musicpost < ApplicationRecord
  belongs_to :user
  has_many :classifications, dependent: :destroy
  has_many :taxons, through: :classifications

  has_one_attached :audio
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :overview, length: { maximum: 300 }
  validates :audio, presence: true
end
