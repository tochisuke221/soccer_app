FactoryBot.define do
  factory :pcomment do
    comment       {Faker::Lorem.sentence}
    association :user
    association :practice
  end
end
