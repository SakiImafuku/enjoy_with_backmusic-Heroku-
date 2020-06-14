# Taxonomy
[
  '作曲家',
  '演奏楽器',
].each.with_index(1) do |name, i|
  Taxonomy.create!(name: name, position: i)
end

# Taxon(作曲家)
taxonomy = Taxonomy.find_by(name: "作曲家")
[
  'モーツアルト',
  'ベートーベン',
].each do |name|
  Taxon.create!(name: name, taxonomy_id: 1)
end
