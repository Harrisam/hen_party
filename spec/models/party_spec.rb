require 'spec_helper'

describe Party do

  context 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:budgets) }
    it { should have_many(:date_options) }
    it { should have_many(:participants) }
  end

  context 'assign_chief_hen' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @party = FactoryGirl.create(:party)

      @party.assign_chief_hen(@user)
    end

    it 'should set the party to belong to the user' do
      expect(@party.reload.user).to eq @user
    end

    it 'should make the user a chief hen' do
      expect(@party.reload.user.chief_hen).to be_true
    end

  end

end
