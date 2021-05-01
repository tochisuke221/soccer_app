FactoryBot.define do
  factory :ptag do
    name              {Faker::Name.initials(number: 2)}
  end
end
