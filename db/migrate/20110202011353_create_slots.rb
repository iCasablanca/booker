class CreateSlots < ActiveRecord::Migration
  def self.up
    create_table :slots do |t|
      t.datetime :start
      t.datetime :end
      t.string :email
      t.boolean :bookstatus, :default => :false
      t.integer :hour_id

      t.timestamps
    end
    add_index(:slots, :hour_id) 
  end

  def self.down
    drop_table :slots
  end
end
