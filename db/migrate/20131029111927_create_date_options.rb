class CreateDateOptions < ActiveRecord::Migration
  def change
    create_table :date_options do |t|
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
