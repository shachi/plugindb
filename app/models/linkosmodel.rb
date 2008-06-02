class Linkosmodel < ActiveRecord::Base
  belongs_to :item
  belongs_to :osmodel
end
