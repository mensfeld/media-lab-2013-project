class AddEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :email
      t.string :phone
      t.string :website

      t.timestamps
    end
  end
end
