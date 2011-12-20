class AddPublishedToConversation < ActiveRecord::Migration
  def self.up
    add_column :conversations, :Published, :boolean
  end

  def self.down
    remove_column :conversations, :Published
  end
end
