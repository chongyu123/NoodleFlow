class CreatePads < ActiveRecord::Migration
  def self.up
    create_table :pads do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :pads
  end
end
