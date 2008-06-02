class RssController < ApplicationController
  # rss機能は入れておくべきかな
  def index
    @items = Item.find(:all, :order => "created_at desc",
                       :conditions => ['flags = true'],
                       :page => {:size => 10})
    headers["Content-Type"] = "application/rss+xml; charset=UTF-8"
    respond_to do |format|
      format.xml  { render :xml => @item }
    end
  end
end
