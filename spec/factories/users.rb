FactoryBot.define do
  factory :user, aliases: [:follower, :followed] do
    sequence(:name, "name_1")
    sequence(:email, "example_1@example.com")
    password { 'password' }
    after(:build) do |user|
      user.avatar.attach(io: File.open('app/assets/images/avatar.png'),
                         filename: 'avatar.png',
                         content_type: 'img/png')
    end
  end
end
