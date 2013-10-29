class CreateContactDetails < ActiveRecord::Migration
  def change
    create_table :contact_details do |t|
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_post_code
      t.string :address_town
      t.string :phone_mobile
      t.string :phone_home

      t.timestamps
    end
  end
end
