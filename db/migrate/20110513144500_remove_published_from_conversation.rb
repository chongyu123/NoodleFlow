class RemovePublishedFromConversation < ActiveRecord::Migration
  def self.up
    remove_column :conversations, :Published
  end

  def self.down
    add_column :conversations, :Published, :boolean
  end
end
