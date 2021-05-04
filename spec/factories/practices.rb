FactoryBot.define do
  factory :practice do
    title                 { Faker::Name.initials(number: 2) }
    content               { Faker::Lorem.sentence }
    category_id           { Faker::Number.within(range: 2..7) }
    hardlevel_id          { Faker::Number.within(range: 2..5) }
    association :user

    after(:create) do |practice|
      create(:practice_ptag_relation, practice: practice, ptag: create(:ptag))
    end
  end
end
