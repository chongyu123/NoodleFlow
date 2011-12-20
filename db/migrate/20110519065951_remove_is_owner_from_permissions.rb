class RemoveIsOwnerFromPermissions < ActiveRecord::Migration
  def self.up
    remove_column :permissions, :is_owner
  end

  def self.down
    add_column :permissions, :is_owner, :boolean
  end
end
