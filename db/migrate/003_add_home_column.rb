class AddHomeColumn < ActiveRecord::Migration
  def self.up
    add_column :homes, :ver, :string
    add_column :homes, :conf, :string
    add_column :homes, :rating, :float
  end

  def self.down
    remove_column :homes, :ver
    remove_column :homes, :conf
    remove_column :homes, :rating
  end
end