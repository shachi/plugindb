# == Schema Information
# Schema version: 10
#
# Table name: items
#
#  id            :integer       not null, primary key
#  name          :string(255)   not null
#  description   :text          not null
#  ver           :string(255)   
#  conf          :string(255)   
#  urls          :string(255)   
#  s_description :string(255)   
#  created_at    :datetime      
#  updated_at    :datetime      
#  rate          :integer       default(0), not null
#  flags         :boolean       not null
#  homeurl       :string(255)   
#

class Item < ActiveRecord::Base
  acts_as_taggable
  has_many :rating, :dependent => :destroy
  has_many :linkosmodel, :dependent => :destroy
  has_many :linkver, :dependent => :destroy
  
  validates_uniqueness_of :name, :message => "同じ名前は使えません"
  
  validates_presence_of :name, :message => "を入力して下さい"
  validates_presence_of :urls, :message => "を入力して下さい"
  validates_presence_of :description, :message => "を入力して下さい"
  validates_presence_of :s_description, :message => "を入力して下さい"
end
