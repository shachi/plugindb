class CreateLinkvers < ActiveRecord::Migration
  def self.up
    create_table :linkvers do |t|
      t.integer "item_id", :default => 0, :null => false
      t.integer "vers_id", :default => 0, :null => false
      t.timestamps 
    end
  end

  def self.down
    drop_table :linkvers
  end
end
