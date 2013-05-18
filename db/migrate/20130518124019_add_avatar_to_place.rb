class AddAvatarToPlace < ActiveRecord::Migration
  def change
    add_attachment :places, :avatar
  end
end
