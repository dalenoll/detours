class AddPostcriptFieldToPrinter < ActiveRecord::Migration
  def self.up
	add_column :locations, :printer_is_postscript, :integer
  end

  def self.down
	remove_column :locations, :printer_is_postscript
  end
end
