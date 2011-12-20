class AddIsOwnerToPermissions < ActiveRecord::Migration
  def self.up
    add_column :permissions, :is_owner, :boolean
  end

  def self.down
    remove_column :permissions, :is_owner
  end
end
