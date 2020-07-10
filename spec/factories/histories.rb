FactoryBot.define do
  factory :history do
    association :user
    association :musicpost
  end
end
