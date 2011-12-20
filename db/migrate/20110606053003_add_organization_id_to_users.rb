class AddOrganizationIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :organization_id, :int
  end

  def self.down
    remove_column :users, :organization_id
  end
end
