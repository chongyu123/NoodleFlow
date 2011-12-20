class AddPadIdToAttachment < ActiveRecord::Migration
  def self.up
    add_column :attachments, :pad_id, :integer
  end

  def self.down
    remove_column :attachments, :pad_id
  end
end
