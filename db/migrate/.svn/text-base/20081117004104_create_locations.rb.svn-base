class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :short_name
      t.string :long_name
      t.string :fax_number
      t.integer :fax_default
      t.string :phone_number
      t.integer :phone_default
      t.string :email_address
      t.integer :email_dafault
      t.string :printer
      t.integer :printer_default

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
