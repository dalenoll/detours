class CreateControllersAndActions < ActiveRecord::Migration
  def self.up
    create_table :controllers_and_actions do |t|
      t.string :name
      t.string :controller
      t.string :action

      t.timestamps
    end
  end

  def self.down
    drop_table :controllers_and_actions
  end
end
