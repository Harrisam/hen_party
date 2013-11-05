class AddKonnectionToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :konnection, :string
  end
end
