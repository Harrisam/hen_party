# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact_detail do
    address_line_1 "MyString"
    address_line_2 "MyString"
    address_post_code "MyString"
    address_town "MyString"
    phone_mobile "MyString"
    phone_home "MyString"
  end
end
