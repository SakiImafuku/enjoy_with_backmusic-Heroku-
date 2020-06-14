FactoryBot.define do
  factory :taxon do
    association :taxonomy
    name { "MyString" }
    taxonomy_id { taxonomy.id }
  end
end
