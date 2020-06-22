FactoryBot.define do
  factory :favorite do
    association :user
    association :musicpost
  end
end
