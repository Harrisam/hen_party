class CreateJoinTableResponseDateOption < ActiveRecord::Migration
  def change
    create_join_table :responses, :date_options do |t|
      # t.index [:response_id, :date_option_id]
      t.index [:date_option_id, :response_id]
    end
  end
end
