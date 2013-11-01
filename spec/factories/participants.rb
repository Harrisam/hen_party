# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participant do
    sequence(:email) { |n| 'participant#{n}@email.com'}
    password 'password'
    password_confirmation 'password'
  end
end
