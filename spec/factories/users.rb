FactoryBot.define do
  factory :user do
    name                  {'tochikawa'}
    email                 {'test@example'}
    password              {'000000'}
    password_confirmation {password}
    team_name             {'栃川高校'}
    career_id             {2}
    phone_num             {09012341234}
  end
end
