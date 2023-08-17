class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :icon
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
