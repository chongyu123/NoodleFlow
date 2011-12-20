class AddPublished2ToConversation < ActiveRecord::Migration
  def self.up
    add_column :conversations, :published, :boolean
  end

  def self.down
    remove_column :conversations, :published
  end
end
