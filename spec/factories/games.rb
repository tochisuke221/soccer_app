FactoryBot.define do
  factory :game do
    title                    {Faker::Name.initials(number: 2)}
    gameday                  {Faker::Time.between(from: DateTime.now + 1, to: DateTime.now)}
    location                 {Faker::Name.initials(number: 2)}
    gametime_id              {Faker::Number.within(range: 2..7)}
    gamenum_id               {Faker::Number.within(range: 2..7)}
    level_id                 {Faker::Number.within(range: 2..7)}
    description              {Faker::Lorem.sentence}
    check                    {false}

     association :user
  end
end
