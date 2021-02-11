class AddDetourUpdate < ActiveRecord::Migration
  def self.up
	add_column :detours, :change_addr, :string
	add_column :detours, :change_at, :datetime
	add_column :detours, :change_pdf_path, :string
  end

  def self.down
	remove_column :detours, :change_addr
	remove_column :detours, :change_at
	remove_column :detours, :change_pdf_path
  end
end
