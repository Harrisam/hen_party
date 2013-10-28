Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then(/^I should see a new Hen Party$/) do
  expect(current_path).to eq new_party_path
end

When(/^I click "(.*?)"$/) do |link_text|
  click_link link_text 
end

When(/^I submit the sign up form with valid details$/) do
  fill_in 'Email', with: 'email@email.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  click_button 'Sign up'
end

Then(/^I should be logged in$/) do
  expect(current_path).to eq root_path
  expect(page).to have_css('.alert', 'Welcome! You have signed up successfully.')
end