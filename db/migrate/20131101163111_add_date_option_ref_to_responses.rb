class AddDateOptionRefToResponses < ActiveRecord::Migration
  def change
    add_reference :responses, :date_option, index: true
  end
end
