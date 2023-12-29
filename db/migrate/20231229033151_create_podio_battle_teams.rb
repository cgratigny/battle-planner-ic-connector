class CreatePodioBattleTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :podio_battle_teams do |t|
      t.string :name
      t.string :team_hash
      t.bigint :team_id
      t.text :members_array, array: true, default: [] 
      t.string :team_type

      t.boolean :pending_processing

      t.timestamps
    end
  end
end
