class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :city
      t.date :reservation_checkin_date
      t.date :reservation_checkout_date
      t.references :user, null: false, foreign_key: true
      t.references :house, null: false, foreign_key: true

      t.timestamps
    end
  end
end
