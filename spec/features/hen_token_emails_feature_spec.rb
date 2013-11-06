require 'spec_helper'

describe 'Invite Hens to a party' do

  before(:each) do
    @user = create(:user)
    @party = create(:party)
    @party.assign_chief_hen(@user)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
  end

  context 'when I have not added Hens to my party' do

    it 'should not have an invite hens button' do
      visit party_path(@party)
      expect(page).not_to have_link 'Invite Hens'
    end

  end

  context 'when I have added Hens to my party' do
    
    before(:each) do
      @participant = create(:participant)
      @party.participants << @participant
    end

    it 'should have one hen' do
      expect(@party.participants.count).to eq 1
    end

    it 'should have an invite hens button' do
      visit party_path(@party)
      click_link('Invite Hens')
      expect(current_path).to eq new_party_invitation_path(@party)
    end

    context 'invitation page' do

      before(:each) do
        visit new_party_invitation_path(@party)
      end

      it 'should have a draft message' do
        expect(find_field('Subject').value).to include @party.name
        expect(find_field('Message').value).to include @user.first_name
      end

      it 'should let me write an email' do
        fill_in 'Subject', with: 'Subject line'
        fill_in 'Message', with: 'Special message to the hens'
        click_button 'Send invitation'

        expect(current_path).to eq party_path(@party)
        expect(page).to have_css('.alert', text: 'Invitations successfully sent.')
      end

      context 'invitation emails' do

        before(:each) do
          fill_in 'Subject', with: 'Subject line'
          fill_in 'Message', with: 'Special message to the hens'
          click_button 'Send invitation'
        end
        
        it 'should have the chosen subject line' do
          expect(emails.last.subject).to eq 'Subject line'
        end

        it 'should have the chosen message' do
          expect(emails.last.body).to include 'Special message to the hens'
        end

        it 'should have the link with token to join the party' do
          expect(emails.last.body).to include @participant.token
        end
      
      end

    end

    context 'join page' do

      before(:each) do
        click_link 'Sign out'
      end

      context 'when an invalid token is used' do

        it 'should show a party not found message' do
          visit join_party_path('123')

          expect(page).to have_content "Sorry, we can't find your party."
        end

      end

      context 'when a valid token is used' do

        before(:each) do
          @date_option = @party.date_options.create(start_date: '2014/01/01', end_date: '2014/02/02')
          @budget = @party.budgets.create(amount: 250)
          visit join_party_path(@participant.token)
        end

        it 'should show party sign up details' do
          expect(page).to have_content "Welcome to #{@party.name}"
        end

        it 'should show the date options' do
          expect(page).to have_content '1/1/14 - 2/2/14'
        end

        it 'should show the budget options' do
          expect(page).to have_content '250'
        end

        it 'should have an opt in for each date option' do
          check "date_option_#{@date_option.id}"
        end

        it 'should have an opt in for each budget option' do
          check "budget_option_#{@budget.id}"
        end

      end

    end

  end

end
