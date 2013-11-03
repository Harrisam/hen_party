require 'spec_helper'

describe 'Plan a Hen Party' do

  before(:each) do
    @user = create(:user)
    @party = create(:party)
    @party.assign_chief_hen(@user)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
  end

  it 'link from the show page' do
    visit party_path(@party)
    click_link 'Plan this party'
    expect(current_path).to eq plan_party_path(@party)
  end
  
  context 'plan page' do

    it 'should have a title' do
      visit plan_party_path(@party)
      expect(page).to have_content "Plan #{@party.name}"
    end

  end

end
