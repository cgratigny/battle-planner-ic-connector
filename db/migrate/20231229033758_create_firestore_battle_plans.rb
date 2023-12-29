class CreateFirestoreBattlePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :firestore_battle_plans do |t|
      t.belongs_to :firestore_user

      t.string :quarter
      t.date :start_date
    
      t.json :calibration_data
      t.json :connection_data
      t.json :condition_data
      t.json :contribution_data
    
      t.integer :calibration_success_days
      t.integer :connection_success_days
      t.integer :condition_success_days
      t.integer :contribution_success_days
    
      t.integer :calibration_percentage
      t.integer :connection_percentage
      t.integer :condition_percentage
      t.integer :contribution_percentage
    
      t.integer :total_days
    
      t.timestamps
    end
  end
end
