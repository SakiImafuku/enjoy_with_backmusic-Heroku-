FactoryBot.define do
  factory :musicpost do
    association :user
    title { "MyString" }
    overview { "MyText" }
  end
end
