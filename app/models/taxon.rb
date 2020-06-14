class Taxon < ApplicationRecord
  belongs_to :taxonomy
  has_many :classifications, dependent: :destroy
  has_many :musicposts, through: :classifications

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :taxonomy_id, presence: true
end
