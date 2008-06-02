class DelItemVeros < ActiveRecord::Migration
  def self.up
    remove_column :items, :ver
    remove_column :items, :conf
    
    add_index :linkosmodels, [:item_id, :osmodel_id]
    add_index :linkvers, [:item_id, :vers_id]
    add_index :osmodels, [:name]
    add_index :vers, [:name]
  end
  
  def self.down
    add_column :items, :ver, :string
    add_column :items, :conf, :string
    
    remove_index :linkosmodels, [:item_id, :osmodel_id]
    remove_index :linkvers, [:item_id, :vers_id]
    remove_index :osmodels, [:name]
    remove_index :vers, [:name]
  end
end