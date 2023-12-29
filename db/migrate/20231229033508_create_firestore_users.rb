class CreateFirestoreUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :firestore_users do |t|
      t.string :firestore_id
      t.string :name
      t.string :email

      t.string :team_id
      t.string :team_name
      t.integer :age
      t.string :image_url
      t.string :iron_council_email
      t.string :phone
      t.string :zip_code
      t.string :gender
      t.datetime :start_date
      t.string :plan_url
      t.string :status

      t.timestamp :account_created_at

      t.references :podio_team

      t.timestamps
    end
  end
end
