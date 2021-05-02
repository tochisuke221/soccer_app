FactoryBot.define do
  factory :practice_ptag_relation do
    association :practice
    association :ptag
  end
end
