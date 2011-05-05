class AddUserIdToHours < ActiveRecord::Migration
  def self.up
    add_column :hours, :user_id, :integer
  end

  def self.down
    remove_column :hours, :user_id
  end
end
