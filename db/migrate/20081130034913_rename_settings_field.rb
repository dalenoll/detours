class RenameSettingsField < ActiveRecord::Migration
  def self.up
    remove_column :settings, :paramter
    add_column :settings, :parameter, :string
  end

  def self.down
    remove_column :settings, :parameter
    add_column :settings, :paramter, :string
  end
end
