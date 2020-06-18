FactoryBot.define do
  factory :classification do
    association :musicpost
    association :taxon
  end
end
