require 'spec_helper'

describe Response do
  it { should belong_to(:participant) }
  it { should have_and_belong_to_many(:budgets) }
  it { should have_and_belong_to_many(:date_options) }
end
