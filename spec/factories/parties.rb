# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :party do
    sequence(:name) {|n| "Bride#{n}"}
  end
end
