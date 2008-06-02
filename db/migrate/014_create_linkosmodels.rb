class CreateLinkosmodels < ActiveRecord::Migration
  def self.up
    create_table :linkosmodels do |t|
      t.integer "item_id", :default => 0, :null => false
      t.integer "osmodel_id", :default => 0, :null => false
      t.timestamps 
    end
  end

  def self.down
    drop_table :linkosmodels
  end
end
