require 'spec_helper'

describe DateOption do
  it { should belong_to(:party) }
  it { should have_many(:participants) }
  it { should have_and_belong_to_many(:responses) }
end
