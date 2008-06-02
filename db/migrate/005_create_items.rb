class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string   "name", :null => false
      t.text     "discription", :null => false
      t.string   "ver"
      t.string   "conf"
      t.string   "urls"
      t.string   "s_discription"

      t.timestamps 
    end
    
    add_index :items, [:name, :discription, :s_discription] 
  end

  def self.down
    drop_table :items
  end
end
