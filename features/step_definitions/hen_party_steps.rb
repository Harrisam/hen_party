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

When(/^I click "(.*?)"$/) do |link_text|
  click_link link_text 
end

When(/^I press "(.*?)"$/) do |button_text|
  click_button button_text
end

When(/^I enter a Bride's name$/) do
  fill_in "Bride's name", with: 'Sam'
end

Then(/^I should be signed in$/) do
  expect(current_path).to eq party_path(Party.last)
  expect(page).not_to have_link 'Sign in'
  expect(page).to have_link 'Sign out'
  within '.navbar' do
    expect(page).to have_content 'Hi Sam!'
  end
end

Then(/^I should be signed out$/) do
  expect(current_path).to eq new_user_session_path
  expect(page).not_to have_link 'Sign out'
  within '.navbar' do
    expect(page).not_to have_content 'Hi Sam!'
  end
  expect(page).to have_link 'Sign in'
end

Given(/^I have an account$/) do
  visit root_path

  fill_in "Bride's name", with: 'Sam'

  click_button 'Create Party'

  fill_in 'First name', with: 'Sam'
  fill_in 'Last name', with: 'Harris'
  fill_in 'Email', with: 'email@email.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'

  click_button 'Create Party'

  click_link 'Sign out'
end

Given(/^I have signed in$/) do
  visit new_user_session_path

  fill_in 'Email', with: 'email@email.com'
  fill_in 'Password', with: 'password'

  click_button 'Sign in'
end

When(/^I submit the new hen party form with valid details$/) do
  fill_in 'First name', with: 'Sam'
  fill_in 'Last name', with: 'Harris'
  fill_in 'Email', with: 'email@email.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'

  click_button 'Create Party'
end

When(/^I submit the sign in form with valid details$/) do
  fill_in 'Email', with: 'email@email.com'
  fill_in 'Password', with: 'password'

  click_button 'Sign in'
end

Then(/^I should not see "(.*?)"$/) do |text|
  expect(page).not_to have_content(text)
end

Then(/^I should see a welcome message$/) do
  expect(page).to have_css('.alert', text: 'Party was successfully created.')
  expect(page).not_to have_link('Sign in')
  within '.navbar' do
    expect(page).to have_content 'Hi Sam!'
  end
end

Then(/^I should see a welcome back message$/) do
  expect(page).to have_css('.alert', text: 'Signed in successfully.')
  expect(page).not_to have_link('Sign in')
  within '.navbar' do
    expect(page).to have_content 'Hi Sam!'
  end
end

When(/^I try to access it$/) do
  visit party_path(Party.last)
end

Then(/^I should receive a confirmation email$/) do
  expect(emails.last.subject).to have_content 'Welcome to Hen Party'
  expect(emails.last.body).to have_content 'Sam'
  expect(emails.last.body).to have_content "You have just created Sam's Hen Party"
  expect(emails.last.body).to have_link "Plan Sam's Hen Party"
  expect(emails.last.body).to include party_path(Party.last)
end
