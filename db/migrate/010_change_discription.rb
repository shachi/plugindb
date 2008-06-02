class ChangeDiscription < ActiveRecord::Migration
  def self.up
    rename_column :items, :discription, :description
    rename_column :items, :s_discription, :s_description
    
    remove_index :items, [:name, :discription, :s_discription]
    add_index :items, [:name, :description, :s_description] 
  end

  def self.down
    rename_column :items, :description, :discription
    rename_column :items, :s_description, :s_discription
    
    remove_index :items, [:name, :description, :s_description]
    add_index :items, [:name, :discription, :s_discription]
  end
end