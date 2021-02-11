class FixEmailDefaultInLocation < ActiveRecord::Migration
  def self.up
    remove_column :locations, :email_dafault
    add_column  :locations, :email_default, :integer
  end

  def self.down
    remove_column :locations, :email_default
    add_column  :locations, :email_dafault, :integer
  end
end
