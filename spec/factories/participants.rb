# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participant do
    sequence(:first_name) { |n| "Joe#{n}" }
    sequence(:last_name) { |n| "Bloggs#{n}"}
    sequence(:email) { |n| 'participant#{n}@email.com'}
    sequence(:konnection) { |n| "connection#{n}" }
  end
end
