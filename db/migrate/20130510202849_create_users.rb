class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :unique => true, :null => false, :default => ''

      t.timestamps
    end
  end
end
