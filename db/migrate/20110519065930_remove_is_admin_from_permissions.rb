class RemoveIsAdminFromPermissions < ActiveRecord::Migration
  def self.up
    remove_column :permissions, :is_admin
  end

  def self.down
    add_column :permissions, :is_admin, :boolean
  end
end
