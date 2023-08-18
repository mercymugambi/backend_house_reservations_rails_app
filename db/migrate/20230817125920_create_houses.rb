class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :icon
      t.string :name
      t.string :description
      # t.references :user, null: false, foreign_key: true
      t.references :admin_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
