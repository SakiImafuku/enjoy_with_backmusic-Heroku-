class Classification < ApplicationRecord
  belongs_to :musicpost
  belongs_to :taxon

  validates :musicpost_id, presence: true
  validates :taxon_id, presence: true
end
