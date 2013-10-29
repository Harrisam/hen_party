require 'spec_helper'

describe ContactDetail do
  it { should belong_to(:user)}
end
