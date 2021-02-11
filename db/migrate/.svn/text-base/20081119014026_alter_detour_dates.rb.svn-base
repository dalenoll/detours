class AlterDetourDates < ActiveRecord::Migration
  def self.up
    change_column :detours, :start_date, :time
    change_column :detours, :end_date, :time
  end

  def self.down
    change_column :detours, :start_date, :date
    change_column :detours, :end_date, :date
  end
end
