class CreatePodioMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :podio_members do |t|
      t.bigint :podio_member_id
      t.bigint :podio_team_id
      t.string :podio_team_name

      t.string :iron_council_email
      t.string :full_name
      t.string :first_name
      t.string :last_name
      t.string :status
      t.string :email
      t.boolean :pending_processing
    
      t.timestamps
    end
  end
end
