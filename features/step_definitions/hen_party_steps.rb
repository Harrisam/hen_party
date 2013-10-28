Given(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I should see a new Hen Party$/) do
  expect(current_path). to eq new_party_path
end

When(/^I click "(.*?)"$/) do |link_text|
  click_link link_text 
end

Then(/^I should be on the sign up page$/) do
  expect(current_path). to eq new_user_registration_path
end