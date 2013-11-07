require 'spec_helper'
include ActionView::Helpers::NumberHelper

describe 'Hen responds to a party invitation' do 

  before(:each) do  
    @party = create(:party, 
            participants: [create(:participant)],
            budgets: [create(:budget), create(:budget)],
            date_options: [create(:date_option), create(:date_option)])
    
    @participant            = @party.participants.last

    @budget_opt_in          = @party.budgets.first
    @budget_opt_in_checkbox = "budget_option_#{@budget_opt_in.id}"
    @budget_opt_out         = @party.budgets.last

    @date_option_opt_in          = @party.date_options.last
    @date_option_opt_in_checkbox = "date_option_#{@date_option_opt_in.id}"
    @date_option_opt_out         = @party.date_options.first

    visit join_party_path(@participant.token)
  end

  context 'join page' do

    it 'should let me opt out of a budget' do
      check @budget_opt_in_checkbox
    end

    it 'should let me opt out of a date' do
      check @date_option_opt_in_checkbox
    end

    it 'should let me submit my response' do  
      check @budget_opt_in_checkbox
      check @date_option_opt_in_checkbox
      click_button "Join the party"
      expect(page).to have_content "Your response has been well received, it's party time!"
    end

    context 'should send me an email confirmation' do

      before(:each) do
        check @budget_opt_in_checkbox
        check @date_option_opt_in_checkbox
        click_button "Join the party"
      end

      it 'that I have joined the party' do
        expect(emails.last.body).to have_content "You have joined #{@party.name}"
      end

      context 'with details of my response' do

        example 'budgets I can afford' do
          expect(emails.last.body).to have_content "#{number_to_currency @budget_opt_in.amount}"

          expect(emails.last.body).not_to have_content "#{number_to_currency @budget_opt_out.amount}"
        end

        example 'dates I can make' do
          expect(emails.last.body).to have_content "#{I18n.l @date_option_opt_in.start_date} - #{I18n.l @date_option_opt_in.end_date}"

          expect(emails.last.body).not_to have_content "#{I18n.l @date_option_opt_out.start_date} - #{I18n.l @date_option_opt_out.end_date}"
        end

      end

    end

  end

end
