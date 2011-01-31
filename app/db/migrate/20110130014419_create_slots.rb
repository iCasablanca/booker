class CreateSlots < ActiveRecord::Migration
  def self.up
    create_table :slots do |t|
      t.datetime :start
      t.datetime :end
      t.boolean :bookstatus, :default => false
      t.string :email
      t.integer :hours_id


      t.timestamps
    end
    add_index :slots, :hours_id
  end

  def self.down
    drop_table :slots
  end
end

