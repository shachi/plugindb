# == Schema Information
# Schema version: 10
#
# Table name: ratings
#
#  id         :integer       not null, primary key
#  item_id    :integer       default(0), not null
#  star       :integer       default(0), not null
#  created_at :datetime      
#  updated_at :datetime      
#

class Rating < ActiveRecord::Base
  belongs_to :item
end
