class AddStatusToPermissions < ActiveRecord::Migration
  def self.up
    add_column :permissions, :status, :integer
  end

  def self.down
    remove_column :permissions, :status
  end
end
