class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.text :description
      t.boolean :wifi
      t.boolean :projector
      t.integer :seat_amount
      t.boolean :socket

      t.timestamps
    end
  end
end
