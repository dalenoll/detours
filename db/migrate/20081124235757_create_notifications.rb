class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :detour_id
      t.integer :location_id
      t.string :notification_type
      t.string :notification_method
      t.integer :acknowledge_requested
      t.datetime :last_attempt
      t.integer :delivered
      t.datetime :acknowledged_at

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
