class ChangeDetourDates2 < ActiveRecord::Migration
  def self.up
    change_column :detours, :start_date, :date
    change_column :detours, :end_date, :date
    add_column :detours, :start_time, :time
    add_column :detours, :end_time, :time
  end

  def self.down
    remove_column :detours, :start_time
    remove_column :detours, :end_time
    change_column :detours, :start_date, :time
    change_column :detours, :end_date, :time
  
  end
end
