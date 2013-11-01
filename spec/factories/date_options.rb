# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :date_option do
    sequence(:start_date) { |n| Date.today + n.days }
    sequence(:end_date) { |n| Date.today + (n + 1).days }
  end
end
