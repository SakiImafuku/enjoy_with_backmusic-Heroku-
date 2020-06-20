FactoryBot.define do
  factory :user, aliases: [:follower, :followed] do
    sequence(:name, "name_1")
    sequence(:email, "example_1@example.com")
    password { 'password' }
  end
end
