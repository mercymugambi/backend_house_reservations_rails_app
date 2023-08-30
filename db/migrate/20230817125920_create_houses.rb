class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :icon
      t.string :house_name
      t.string :city
      t.string :description
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :rent
      t.integer :security_deposit
      t.string :contact_phone_number
      t.references :admin_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
