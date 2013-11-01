class CreateJoinTableResponseBudget < ActiveRecord::Migration
  def change
    create_join_table :responses, :budgets do |t|
      # t.index [:response_id, :budget_id]
      t.index [:budget_id, :response_id]
    end
  end
end
