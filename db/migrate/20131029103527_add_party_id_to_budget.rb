class AddPartyIdToBudget < ActiveRecord::Migration
  def change
    add_reference :budgets, :party, index: true
  end
end
