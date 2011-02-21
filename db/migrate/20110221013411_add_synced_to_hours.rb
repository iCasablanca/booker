class AddSyncedToHours < ActiveRecord::Migration
  def self.up
    add_column :hours, :synced, :boolean, :default => false
  end

  def self.down
    remove_column :hours, :synced
  end
end
