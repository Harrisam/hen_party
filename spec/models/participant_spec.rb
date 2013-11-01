require 'spec_helper'

describe Participant do
  it { should belong_to(:party) }
  it { should have_many(:budgets) }
  it { should have_many(:date_options) }
end
