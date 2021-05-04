FactoryBot.define do
  factory :chat_message do
    content        {Faker::Lorem.sentence}
    check          {false}
    association :user
    association :chat_room
  end
end
