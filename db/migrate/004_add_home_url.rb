class AddHomeUrl < ActiveRecord::Migration
  def self.up
    add_column :homes, :urls, :string
    add_column :homes, :s_discription, :string
  end

  def self.down
    remove_column :homes, :urls
    remove_column :homes, :s_discription
  end
end