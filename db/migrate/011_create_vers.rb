class CreateVers < ActiveRecord::Migration
  def self.up
    create_table :vers do |t|
      t.string   "name", :null => false
      t.timestamps 
    end
    
    Vers.create(:name => "1.1.*")
    Vers.create(:name => "1.2.*")
    Vers.create(:name => "2.0.*")
    Vers.create(:name => "edge")
  end

  def self.down
    drop_table :vers
  end
end
