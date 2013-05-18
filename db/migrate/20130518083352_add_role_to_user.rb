class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, :null => false, :before => :created_at, :default => ''
  end
end
