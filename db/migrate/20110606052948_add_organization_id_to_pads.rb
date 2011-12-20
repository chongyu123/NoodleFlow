class AddOrganizationIdToPads < ActiveRecord::Migration
  def self.up
    add_column :pads, :organization_id, :int
  end

  def self.down
    remove_column :pads, :organization_id
  end
end
