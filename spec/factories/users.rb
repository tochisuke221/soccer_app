FactoryBot.define do
  factory :user do
    name              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    team_name             {'栃川高校'}
    career_id             {Faker::Number.within(range: 2..5)}
    phone_num             {Faker::Number.number(digits: 11)}
  end
end
