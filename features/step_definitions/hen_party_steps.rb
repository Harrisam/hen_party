Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I click 'Create Hen Party'$/) do
  click_link 'Create Hen Party'
end

Then(/^I should see a new Hen Party$/) do
  expect(current_path). to eq new_party_path
end