class Taxonomy < ApplicationRecord
  has_many :taxons, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :position, presence: true
end
