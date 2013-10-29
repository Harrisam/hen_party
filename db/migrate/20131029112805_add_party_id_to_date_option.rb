class AddPartyIdToDateOption < ActiveRecord::Migration
  def change
    add_reference :date_options, :party, index: true
  end
end
