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
      # raise page.html.inspect
      @hen = Participant.new(email: 'hen@hen.com', first_name: 'Jen', last_name: 'Hen')

      @party.participants << @hen
    end

    it 'should have one hen' do
      expect(@party.participants.count).to eq 1
    end

    it 'should have an invite hens button' do
      visit party_path(@party)
      # save_and_open_page
      click_link('Invite Hens')
      expect(current_path).to eq party_invitation_path(@party)
    end

  end

end
