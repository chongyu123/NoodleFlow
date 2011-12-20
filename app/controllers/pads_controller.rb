class PadsController < ApplicationController
  before_filter :init_pad
  
  # GET /Pads
  # GET /Pads.xml
  def index
    @events = session[:organization].events.top_events

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pads }
    end
  end

  # GET /Pads/1
  # GET /Pads/1.xml
  def show
    @pad = session[:organization].pads.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pad }
    end
  end

  # GET /Pads/new
  # GET /Pads/new.xml
  def new
    @pad = Pad.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pad }
    end
  end

  # GET /Pads/1/edit
  def edit
    @pad = session[:organization].pads.find(params[:id])
  end

  # POST /Pads
  # POST /Pads.xml
  def create
    @pad = session[:organization].pads.create(params[:pad])

    respond_to do |format|
      if @pad.save
        user_id = session[:user_id]
        
        permission = Permission.new(:user_id => user_id, :pad_id => @pad.id, :status => Permission::STAT_OWNER)
        permission.save
        
        desc = @pad.name + ", " + @pad.description
        add_event( EVENT_NEW_PAD, desc[0,150], EVENTSOURCE_USER, session[:user_id], session[:user_name], nil )
        
        format.html { redirect_to(@pad, :notice => 'pad was successfully created.') }
        format.xml  { render :xml => @pad, :status => :created, :location => @pad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /Pads/1
  # PUT /Pads/1.xml
  def update
    @pad = session[:organization].pads.find(params[:id])

    respond_to do |format|
      if @pad.update_attributes(params[:pad])

        desc = @pad.name + ", " + @pad.description
        add_event( EVENT_UPDATE_PAD, desc[0,150], EVENTSOURCE_USER, session[:user_id], session[:user_name], nil )

        format.html { redirect_to(@pad, :notice => 'pad was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /Pads/1
  # DELETE /Pads/1.xml
  def destroy
    @pad = session[:organization].pads.find(params[:id])

    desc = @pad.name
    add_event( EVENT_DELETE_PAD, desc[0,150], EVENTSOURCE_USER, session[:user_id], session[:user_name], nil )
    
    @pad.destroy

    respond_to do |format|
      format.html { redirect_to(pads_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def init_pad
    @pads = session[:organization].pads
    
    if !params[:id].nil?
      @pad = session[:organization].pads.find(params[:id])
      @tabs = @pad.tab_counts
      @selected_tab = :public
    end
    
  end

end
