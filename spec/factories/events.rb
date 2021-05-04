FactoryBot.define do
  factory :event do
    title               { Faker::Lorem.sentence }
    start_time          { Faker::Time.between(from: DateTime.now + 1, to: DateTime.now) }
    association :user
  end
end
