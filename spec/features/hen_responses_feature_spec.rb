require 'spec_helper'

describe 'hen responses' do 

  before(:each) do  
    @party = create(:party, 
            participants: [create(:participant)],
            budgets: [create(:budget), create(:budget)],
            date_options: [create(:date_option), create(:date_option)])
    
    @participant = @party.participants.last
    @budget = @party.budgets.first
    @date_option = @party.date_options.last 

    visit join_party_path(@participant.token)
  end

  it 'should let me opt out of a budget' do
    check "budget_#{@budget.id}"
  end

  it 'should let me opt out of a date' do
    check "date_option_#{@date_option.id}"
  end

  it 'should let me submit my response' do  
    check "budget_#{@budget.id}"
    check "date_option_#{@date_option.id}"
    click_button "Join the party"
  end

end
