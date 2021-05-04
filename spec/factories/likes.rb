FactoryBot.define do
  factory :like do
    association :user
    association :practice
  end
end
