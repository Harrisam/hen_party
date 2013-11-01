require 'spec_helper'

describe 'Edit Hen Party' do

  before(:each) do
    visit new_party_path

    fill_in 'Name', with: 'Bridezilla on the rampage'

    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Create Party'

    @party = Party.last
    @user = User.last
  end

  context 'when I land on the edit hen party' do

    it 'should have an Add Budget Options Link' do 
      visit edit_party_path(@party)
      expect(page).to have_content 'Add Budget Options'
    end

    it 'should have an Add Date Options Link' do 
      visit edit_party_path(@party)
      expect(page).to have_content 'Add Date Option'
    end

    it 'should have an Add Participants Link' do 
      visit edit_party_path(@party)
      expect(page).to have_content 'Add Participant'
    end
  end

  context 'when I have not added any options to hen party' do

    it 'should not have a budget field' do
      visit edit_party_path(@party)
      expect(page).not_to have_content 'Budget Amount'
    end


    it 'should not have a date field' do
      visit edit_party_path(@party)
      expect(page).not_to have_content 'Start Date'
    end

    it 'should not have a participant field' do
      visit edit_party_path(@party)
      expect(page).not_to have_content 'email address'
    end
  end

  context 'when I add a budget to hen party' do

    xit 'should display budget fields' do
      visit edit_party_path(@party)
      page.find('.AddBudgetOptions').click
    
      fill_in 'party[budgets_attributes][0][amount]', :with => '500'
         
      expect(page).to have_content '500'
    end


    xit 'should display date fields' do
      visit edit_party_path(@party)
      page.find('.AddDateOption').click 

      expect(page).to have_content 'Start Date'
    end

    xit 'should display participant fields', js: true do
      visit edit_party_path(@party)
      puts page.html
      page.find('.add_participant').click 
      expect(page).to have_css 'body'
    end
  end

  context 'when I have added Particpants to my party' do
    
    before(:each) do
      @party.participants.create(email: 'hen@hen.com', first_name: 'Jen', last_name: 'Hen')
    end

    it 'should have one participant' do
      expect(@party.participants.count).to eq 1
    end

     it 'should have participants' do
       visit edit_party_path(@party)
       expect(page).to have_css 'input#party_participants_attributes_0_first_name'
       expect(page).to have_css 'input#party_participants_attributes_0_last_name'
       expect(page).to have_css 'input#party_participants_attributes_0_email'
    end
  end
  
  context 'when I have added Budgets to my party' do
    
    before(:each) do
      @party.budgets.create(amount: 250)
    end

    it 'should have one participant' do
      expect(@party.budgets.count).to eq 1
    end

     it 'should have participants' do
       visit edit_party_path(@party)
       expect(page).to have_content 'Budget Amount'
    end
  end

  context 'when I have added Dates to my party' do
    
    before(:each) do
      @party.date_options.create(start_date: '2014/1/1', end_date: '2014/2/2')
    end

    it 'should have one participant' do
      expect(@party.date_options.count).to eq 1
    end

     it 'should have participants' do
       visit edit_party_path(@party)
       expect(page).to have_content 'Start Date'
       expect(page).to have_content 'End Date'
    end
  end
end
