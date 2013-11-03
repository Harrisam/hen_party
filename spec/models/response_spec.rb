require 'spec_helper'

describe Response do
  it { should belong_to(:participant) }
  it { should have_and_belong_to_many(:budgets) }
  it { should have_and_belong_to_many(:date_options) }

  let(:response) { Response.new }

  context 'date_option_ids=' do

    let(:date_option) { create(:date_option) }

    it 'should set date options' do
      date_option_2 = create(:date_option)
      response.date_option_ids = [date_option.id, date_option_2.id]

      expect(response.date_options).to include date_option, date_option_2
    end

    it 'should not set date options more than once' do
      response.date_option_ids = [date_option.id]
      response.date_option_ids = [date_option.id]

      expect(response.date_options.length).to eq 1
    end

  end

  context 'budget_option_ids=' do

    let(:budget_option) { create(:budget) }

    it 'should set budget options' do
      budget_option_2 = create(:budget)
      response.budget_option_ids = [budget_option.id, budget_option_2.id]

      expect(response.budgets).to include budget_option, budget_option_2
    end

    it 'should not set budget options more than once' do
      response.budget_option_ids = [budget_option.id]
      response.budget_option_ids = [budget_option.id]

      expect(response.budgets.length).to eq 1
    end

  end

end
