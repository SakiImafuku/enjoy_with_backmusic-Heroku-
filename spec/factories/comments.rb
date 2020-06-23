FactoryBot.define do
  factory :comment do
    association :user
    association :musicpost
    content { "MyText" }
  end
end
