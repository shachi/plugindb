class AddItemsRate < ActiveRecord::Migration
  def self.up
    add_column :items, :rate, :integer, :default => 0, :null => false
    add_column :items, :flags, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :items, :rate
    remove_column :items, :flags
  end
end