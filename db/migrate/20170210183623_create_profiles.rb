class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id #this'll link to user
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.string :phone_number #this'll be private unless pro
      t.string :contact_email
      t.string :description
      t.timestamps
    end
  end
end
