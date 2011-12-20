class AddPadIdToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :pad_id, :integer
  end

  def self.down
    remove_column :pages, :pad_id
  end
end
