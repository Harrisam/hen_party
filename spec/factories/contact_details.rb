# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact_detail do
    sequence(address_line_1) {|n| "#{n} Bob Street"}
    address_line_2 "Harrington"
    address_post_code "W1 4EB"
    address_town "London"
    phone_mobile "07112567432"
    phone_home "0207456224"
  end
end
