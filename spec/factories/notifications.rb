FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user
    association :visited, factory: :user
    association :musicpost
    association :comment
    action { "favorite" }
    checked { false }
  end
end
