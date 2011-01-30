class CreateHours < ActiveRecord::Migration
  def self.up
    create_table :hours do |t|
      t.datetime :date
      t.datetime :start
      t.string :location
      t.integer :number_slots

      t.timestamps
    end
  end

  def self.down
    drop_table :hours
  end
end
