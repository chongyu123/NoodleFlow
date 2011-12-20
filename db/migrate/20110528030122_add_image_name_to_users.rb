class AddImageNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :image_name, :string
  end

  def self.down
    remove_column :users, :image_name
  end
end
