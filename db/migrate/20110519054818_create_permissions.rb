class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.integer :pad_id
      t.integer :user_id
      t.boolean :is_admin
      t.boolean :send_email_events
      t.boolean :show_dashboard_events

      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
