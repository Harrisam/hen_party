class AddPartyIdToParticipant < ActiveRecord::Migration
  def change
    add_reference :participants, :party, index: true
  end
end
