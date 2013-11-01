# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :budget do
    sequence(:amount) { |n| n * 100 }
  end
end
