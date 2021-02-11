class UpdateCanceledFields < ActiveRecord::Migration
  def self.up
    remove_column :detours, :cancel_sddr
    add_column :detours, :cancel_addr, :string
    add_column :detours, :canceled, :integer
    add_column :detours, :cancel_date, :datetime
  end

  def self.down
    remove_column :detours, :canceled
    remove_column :detours, :cancel_date
    remove_column :detours, :cancel_addr
    add_column :detours, :cancel_sddr, :string
  end
end
