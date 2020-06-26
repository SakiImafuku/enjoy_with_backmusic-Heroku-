FactoryBot.define do
  factory :memo do
    association :user
    association :musicpost
    memo { "MyText" }
  end
end
