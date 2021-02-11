class CreateDetours < ActiveRecord::Migration
  def self.up
    create_table :detours do |t|
      t.date :start_date
      t.date :end_date
      t.string :route
      t.integer :direction
      t.integer :detour_type
      t.text :description
      t.string :supervisor
      t.string :dispatcher
      t.string :reason
      t.string :create_addr
      t.string :cancel_sddr
      t.string :create_pdf_path
      t.string :cancel_pdf_path

      t.timestamps
    end
  end

  def self.down
    drop_table :detours
  end
end
