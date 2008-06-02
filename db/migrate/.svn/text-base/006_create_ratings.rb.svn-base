class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer "item_id", :default => 0, :null => false
      t.integer "star", :default => 0, :null => false
      t.timestamps 
    end
    
    add_index :ratings, [:item_id] 
  end

  def self.down
    drop_table :ratings
  end
end
