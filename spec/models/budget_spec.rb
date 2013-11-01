require 'spec_helper'

describe Budget do
  it { should belong_to(:party) }
  it { should have_many(:participants) }
end
