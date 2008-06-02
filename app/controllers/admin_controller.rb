class AdminController < ApplicationController
  before_filter :authenticate
  layout 'admin'

  # GET /homes
  # GET /homes.xml
  def index
    @items = Item.find(:all, :order => "created_at desc",
                        :page => {:size => 30})
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # more index
  def more_index
    items = Item.find(:all, :order => "created_at desc",
                        :page => {:size => 2, :current => params[:next_page].to_i})
    render :update do |page|
      page.insert_html(:bottom, 'result', {:partial => 'result', :locals => {
                          :items => items }})
      if !items.next_page?
        page.replace_html('more', "")
      end
    end
  end
  
  def flag_switch
    if params[:id].to_s != ""
      item = Item.find(:first, :conditions => ['id = ?', params[:id]])
      item.flags = !item.flags
      item.save
      render :partial => 'flag', :locals => {:item => item }
    end
    return
  end
  
  # GET /homes/1
  # GET /homes/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end
  
  # GET /homes/1/edit
  def edit
    @item = Item.find(params[:id])
    @osmodels = Osmodel.find(:all)
    @vers = Vers.find(:all)
    params[:ver] = @item.linkver.map{|p| p.vers_id.to_s }
    params[:os] = @item.linkosmodel.map{|p| p.osmodel_id.to_s }
  end
  
  # PUT /homes/1
  # PUT /homes/1.xml
  def update
    @item = Item.find(params[:id])
    @osmodels = Osmodel.find(:all)
    @vers = Vers.find(:all)
    Item.transaction do
      respond_to do |format|
        if @item.update_attributes(params[:item])
          @osmodels.each do |osmodel|
            linkosmodel = Linkosmodel.find(:first, :conditions => ['item_id = ? and osmodel_id = ?', @item.id, osmodel.id])
            if params[:os].include?(osmodel.id.to_s)
              linkosmodel = Linkosmodel.create!(:item_id => @item.id, :osmodel_id => osmodel.id) if linkosmodel == nil
            else
              linkosmodel.destroy if linkosmodel != nil
            end
          end
          @vers.each do |vers|
            linkver = Linkver.find(:first, :conditions => ['item_id = ? and vers_id = ?', @item.id, vers.id])
            if params[:ver].include?(vers.id.to_s)
              linkver = Linkver.create!(:item_id => @item.id, :vers_id => vers.id) if linkver == nil
            else
              linkver.destroy if linkver != nil
            end
          end
          flash[:notice] = 'Home was successfully updated.'
          format.html { redirect_to(:action => "show") }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(homes_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == "tetete" && password == "tsutsutsu"
    end
  end
end
