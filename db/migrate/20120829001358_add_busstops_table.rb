class AddBusstopsTable < ActiveRecord::Migration
  def self.up
    create_table "stops", :force => true do |t|
      t.datetime "start_date"
      t.datetime "end_date"
      t.integer  "direction"
      t.text     "description"
      t.string   "supervisor"
      t.string   "dispatcher"
      t.string   "reason"
      t.string   "create_addr"
      t.string   "create_pdf_path"
      t.string   "cancel_addr"
      t.integer  "canceled"
      t.datetime "cancel_date"
      t.string   "cancel_pdf_path"
      t.string   "change_addr"
      t.string   "change_pdf_path"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "change_at"
 
    end

  end

  def self.down
    drop_table stops
  end
end
