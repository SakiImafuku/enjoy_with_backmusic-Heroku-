FactoryBot.define do
  factory :musicpost do
    association :user
    title { "MyString" }
    overview { "MyText" }
    after(:build) do |user|
      user.audio.attach(io: File.open('app/assets/audio/test.m4a'), filename: 'test.m4a', content_type: 'audio/m4a')
    end
  end
end
