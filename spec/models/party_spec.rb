require 'spec_helper'

describe Party do
  it { should belong_to(:user) }
  it { should have_many(:budgets) }
  it { should have_many(:date_options) }
  it { should have_many(:participants) }
end
