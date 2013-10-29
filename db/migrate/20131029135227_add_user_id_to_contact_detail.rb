class AddUserIdToContactDetail < ActiveRecord::Migration
  def change
    add_reference :contact_details, :user, index: true
  end
end
