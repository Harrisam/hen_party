class AddParticipantRefToResponses < ActiveRecord::Migration
  def change
    add_reference :responses, :participant, index: true
  end
end
