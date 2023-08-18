class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :icon
      t.string :name
      t.string :description
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :rent
      t.integer :security_deposit
      t.string :contact_phone_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
