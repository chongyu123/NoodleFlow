class CreateConversations < ActiveRecord::Migration
  def self.up
    create_table :conversations do |t|
      t.string :topic
      t.integer :pad_id

      t.timestamps
    end
  end

  def self.down
    drop_table :conversations
  end
end
