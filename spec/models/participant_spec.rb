require 'spec_helper'

describe Participant do
  it { should belong_to(:party)}
end
