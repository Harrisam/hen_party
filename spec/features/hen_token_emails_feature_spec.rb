require 'spec_helper'

describe 'Invite Hens to a party' do

  context 'when I have added Hens to my party' do
    
    before(:each) do
      visit new_party_path

      fill_in 'Name', with: 'Bridezilla on the rampage'

      fill_in 'Email', with: 'email@email.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_button 'Create Party'

      @party = Party.last
      @user = User.last
      @hen = Participant.new(email: 'hen@hen.com', first_name: 'Jen', last_name: 'Hen')

      @party.participants << @hen
    end

    it 'should have one hen' do
      expect(@party.participants.count).to eq 1
    end

    it 'should have an invite hens button' do
      visit party_path(@party)
      click_link('Invite Hens')
      expect(current_path).to eq party_invitation_path(@party)
    end

    context 'invitation page' do

      before(:each) do
        visit party_invitation_path(@party)
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
          expect(emails.last.body).to include @hen.token
        end
      
      end

    end

  end

end
