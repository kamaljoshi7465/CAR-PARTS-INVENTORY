class CreateProfileSetting < ActiveRecord::Migration[8.0]
  def change
    create_table :profile_settings do |t|
      t.string :company_name, null: false
      t.text :address
      t.string :gst_number
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
