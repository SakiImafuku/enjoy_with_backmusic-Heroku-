class UploadMusicpostForm
  include ActiveModel::Model

  attr_accessor :title, :composer, :instrument, :overview, :audio

  validates :audio, presence: { message: "を選択してください。" }
  validates :title, presence: true, length: { maximum: 50 }
  validates :composer, length: { maximum: 50 }
  validates :instrument, length: { maximum: 50 }
  validates :overview, length: { maximum: 300 }

  def save(user)
    return false if invalid?
    taxons = Taxon.where(name: composer).or(Taxon.where(name: instrument))
    musicpost = user.musicposts.create(user_id: user.id, title: title, overview: overview)
    taxons.each do |taxon|
      musicpost.classifications.create(musicpost_id: musicpost.id, taxon_id: taxon.id)
    end
  end

  def composer_save
    taxonomy = Taxonomy.find_by(name: "作曲家")
    Taxon.create(name: composer, taxonomy_id: taxonomy.id)
  end

  def instrument_save
    taxonomy = Taxonomy.find_by(name: "演奏楽器")
    Taxon.create(name: instrument, taxonomy_id: taxonomy.id)
  end
end
