FactoryBot.define do
  factory :chat_room_user do
    association :user
    association :chat_room
  end
end
