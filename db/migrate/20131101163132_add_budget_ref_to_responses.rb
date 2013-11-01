class AddBudgetRefToResponses < ActiveRecord::Migration
  def change
    add_reference :responses, :budget, index: true
  end
end
