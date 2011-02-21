class AddSyncedToSlots < ActiveRecord::Migration
  def self.up
    add_column :slots, :synced, :boolean, :default => false
  end

  def self.down
    remove_column :slots, :synced
  end
end
