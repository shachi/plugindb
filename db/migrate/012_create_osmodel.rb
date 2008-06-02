class CreateOsmodel < ActiveRecord::Migration
  def self.up
    create_table :osmodels do |t|
      t.string   "name", :null => false
      t.timestamps 
    end
    
    Osmodel.create(:name => "Linux")
    Osmodel.create(:name => "FreeBSD")
    Osmodel.create(:name => "Windows")
    Osmodel.create(:name => "MacOSX")
  end

  def self.down
    drop_table :osmodels
  end
end
