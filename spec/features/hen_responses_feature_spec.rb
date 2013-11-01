require 'spec_helper'

describe 'hen responses' do 

  before(:each) do  
    @party = create(:party, 
            participants: [create(:participant)],
            budgets: [create(:budget), create(:budget)],
            date_options: [create(:date_option), create(:date_option)])
    
    @participant         = @party.participants.last
    @budget_ok           = @party.budgets.last
    @budget_opt_out      = @party.budgets.first
    @date_option_ok      = @party.date_options.first
    @date_option_opt_out = @party.date_options.last

    visit join_party_path(@participant.token)
  end

  it 'should let me opt out of a budget' do
    check "budget_#{@budget_opt_out.id}"
  end

  it 'should let me opt out of a date' do
    check "date_option_#{@date_option_opt_out.id}"
  end

  it 'should let me submit my response' do  
    check "budget_#{@budget_opt_out.id}"
    check "date_option_#{@date_option_opt_out.id}"
    click_button "Join the party"
    expect(page).to have_content "Your response has been well received, it is party time!"
  end

  context 'should send me an email confirmation' do

    before(:each) do
      check "budget_#{@budget_opt_out.id}"
      check "date_option_#{@date_option_opt_out.id}"
      click_button "Join the party"
    end

    it 'with details of my response' do
      expect(emails.last.body).to have_content 'Just to confirm your choices:...'
      expect(emails.last.body).to have_content "£#{@budget_ok.amount}"
      expect(emails.last.body).to have_content "#{@date_option_ok.start_date} - #{@date_option_ok.end_date}"
    end

  end

end
