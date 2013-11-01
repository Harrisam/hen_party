require 'spec_helper'

describe 'hen responses' do 

  before(:each) do  
    @party = create(:party, 
            budgets: [create(:budget), create(:budget)],
            date_options: [create(:date_option), create(:date_option)])
    
    @participant = create(:participant)
    @party.participants << @participant
  end

  it 'should let me opt out of a budget' do
    visit join_party_path(@participant.token)
    @budget = @party.budgets.first
    check "budget_#{@budget.id}"
  end

  it 'should let me opt out of a date' do
    visit join_party_path(@participant.token)
    @date_option = @party.date_options.last
    check "date_option_#{@date_option.id}"
  end

end

