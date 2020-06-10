class Taxon < ApplicationRecord
  belongs_to :taxonomy
  has_many :classifications

  validates :name, presence: true, length: { maximum: 50 }
  validates :taxon_id, presence: true
end
