class PagesController < ApplicationController
  before_filter :init_pad
  layout "pads"

  # GET /pages
  # GET /pages.xml
  def index
    @pages = @pad.pages
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    #@page = Page.new(params[:page])
    @page = @pad.pages.create(params[:page])

    respond_to do |format|
      if @page.save
        
        desc = params[:page][:title] + ", " + params[:page][:body]
        add_event( EVENT_NEW_PAGE, desc, EVENTSOURCE_USER, session[:user_id], session[:user_name], nil)
        
        format.html { redirect_to(pad_pages_path(@pad), :notice => 'Page was successfully created.') }
        format.xml  { render :xml => pad_pages_path(@pad), :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => pad_pages_path(@pad).errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])
    
    # handle publish/unpublish
    if !params[:published].blank?
      if params[:published] == 'y'
        @page.published = true
      else
        @page.published = false
      end        
    end

    #logger.info "PAGE CONTAINS: " + params[:page].to_s
    #logger.info "PUBLISHED CONTAINS: " + params[:published].to_s + "END"
    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        
        desc = @page.title + ", " + @page.body
        add_event( EVENT_UPDATE_PAGE, desc[0,150], EVENTSOURCE_USER, session[:user_id], session[:user_name], nil)

        format.html { redirect_to(pad_pages_path(@pad), :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])

    desc = @page.title
    add_event( EVENT_DELETE_PAGE, desc[0,150], EVENTSOURCE_USER, session[:user_id], session[:user_name], nil)

    @page.destroy

    respond_to do |format|
      format.html { redirect_to(pad_pages_path(@pad)) }
      format.xml  { head :ok }
    end
  end
    
  private
    def init_pad
      @pads = session[:organization].pads
      @pad = session[:organization].pads.find(params[:pad_id])
      
      @tabs = @pad.tab_counts
      @selected_tab = :page
    end
end
