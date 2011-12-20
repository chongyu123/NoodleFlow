class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :event_type
      t.string :description
      t.integer :source_id
      t.string :source_name
      t.integer :source_type

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
