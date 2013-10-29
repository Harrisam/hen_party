require 'spec_helper'

describe Party do
  it { should have_many(:budgets)}
  it { should have_many(:date_options)}
end
