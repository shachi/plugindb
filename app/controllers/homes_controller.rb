class HomesController < ApplicationController
  layout 'homes', :only => ['index', 'rating', 'show', 'new', 'create']
  PAGE_SIZE = 10
  
  #== 作成順のlist
  # GET /homes
  # GET /homes.xml
  def index
    @current_page = params[:next_page] ? params[:next_page].to_i : 1
    @items = Item.find(:all, :order => "created_at desc",
                       :conditions => ['flags = true'],
                       :page => {:size => PAGE_SIZE, :current => @current_page})
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
      format.js   {
        render :update do |page|
          if @current_page == 1
            page.replace_html('result', {:partial => 'item', :collection => @items})
          else
            page.insert_html(:bottom, 'result', {:partial => 'item', :collection => @items})
          end
          page.replace_html('more', @items.next_page? ? 
            {:partial => 'list_more', :locals => {:current_page => @current_page}} : '')
        end
      }
    end
  end
  
  #== レート順のlist
  #rating
  def rating
    @current_page = params[:next_page] ? params[:next_page].to_i : 1
    @items = Item.find(:all, :order => "rate desc",
                       :conditions => ['flags = true'],
                       :page => {:size => PAGE_SIZE, :current => @current_page})
    
    respond_to do |format|
      format.html # rating.html.erb
      format.xml  { render :xml => @items }
      format.js   {
        render :update do |page|
          if @current_page == 1
            page.replace_html('result', {:partial => 'item', :collection => @items})
          else
            page.insert_html(:bottom, 'result', {:partial => 'item', :collection => @items})
          end
          page.replace_html('more', @items.next_page? ? 
            {:partial => 'rating_more', :locals => {:current_page => @current_page}} : '')
        end
      }
    end
  end
  
  #== tag
  # ajax tag
  def tag
    @current_page = params[:next_page] ? params[:next_page].to_i : 1
    @tag = params[:id]
    itemskey = Item.find_tagged_with(params[:id]).map{|p| [p.id]}.join(" or id = ")
    if itemskey.to_s != ""
      @items = Item.find(:all, :order => "created_at desc",
                         :conditions => "( id = #{itemskey}) and flags = true",
                         :page => {:size => PAGE_SIZE, :current => @current_page})
      respond_to do |format|
        format.html # tag.html.erb
        format.xml  { render :xml => @items }
        format.js   {
          render :update do |page|
            if @current_page == 1
              page.replace_html('result', {:partial => 'item', :collection => @items})
            else
              page.insert_html(:bottom, 'result', {:partial => 'item', :collection => @items})
            end
            page.replace_html('more', @items.next_page? ? 
              {:partial => 'tag_more', :locals => {:current_page => @current_page, :tag => @tag}} : '')
          end
        }
      end
    else
      render :nothing => true
    end
    
  end
  
  #== 検索
  # ajax search
  def search
    @current_page = params[:next_page] ? params[:next_page].to_i : 1
    search = params[:search_text].to_s
    text = "%#{search}%"
    @items = Item.find(:all,
                       :order => "created_at desc",
                       :conditions => ['( name like ? or description like ? or s_description like ? ) and flags = true', text, text, text],
                       :page => {:size => PAGE_SIZE, :current => @current_page})
    respond_to do |format|
      format.html # rating.html.erb
      format.xml  { render :xml => @items }
      format.js   {
        render :update do |page|
          if @current_page == 1
            page.replace_html('result', {:partial => 'item', :collection => @items})
          else
            page.insert_html(:bottom, 'result', {:partial => 'item', :collection => @items})
          end
          page.replace_html('more', @items.next_page? ? 
            {:partial => 'search', :locals => {:current_page => @current_page, :text => search}} : '')
        end
      }
    end
  end

  # rating_up
  def rating_up
    if params[:id].to_s != "" or params[:star].to_s != ""
      rating = Rating.create!(:item_id => params[:id], :star => params[:star])
      # rate計算
      item = Item.find(:first, :conditions => ['id = ?', params[:id]])
      rate = 0.0
      cnt = item.rating.size
      item.rating.each do |rating|
        rate += rating.star.to_f
      end
      rate = ( rate / cnt ) * 20
    
      item.rate = rate
      item.save
      render :partial => 'star', :locals => {:item => item }
    end
    return
  end

# 標準処理

  # GET /homes/1
  # GET /homes/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /homes/new
  # GET /homes/new.xml
  def new
    @item = Item.new
    @osmodels = Osmodel.find(:all)
    @vers = Vers.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end
  
  # POST /homes
  # POST /homes.xml
  def create
    @item = Item.new(params[:item])
    @osmodels = Osmodel.find(:all)
    @vers = Vers.find(:all)
    if params[:kyuuji].to_s == "kyuuji" and ( params[:os] != nil or params[:ver] != nil )
      Item.transaction do
        respond_to do |format|
          if @item.save
            params[:os].each do |os|
              linkosmodel = Linkosmodel.create!(:item_id => @item.id, :osmodel_id => os)
            end
            params[:ver].each do |ver|
              linkver = Linkver.create!(:item_id => @item.id, :vers_id => ver)
            end
            flash[:notice] = '作成しました。更新は管理者の確認後、反映されますのでお待ちください。'
            format.html { redirect_to(homes_url) }
            format.xml  { render :xml => @item, :status => :created, :location => @item }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
          end
        end
      end
    else
      respond_to do |format|
        @item.valid?
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end
end
