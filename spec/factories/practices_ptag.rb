FactoryBot.define do
  factory :practices_ptag do
    name                  { Faker::Name.initials(number: 2) }
    title                 { Faker::Name.initials(number: 2) }
    content               { Faker::Lorem.sentence }
    category_id           { Faker::Number.within(range: 2..7) }
    hardlevel_id          { Faker::Number.within(range: 2..5) }
  end
end
