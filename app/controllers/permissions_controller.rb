class PermissionsController < ApplicationController
  before_filter :init_pad
  layout "pads"
  
  # GET /permissions
  # GET /permissions.xml
  def index
    @pad = Pad.find(params[:pad_id])
    @permissions = @pad.permissions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @permissions }
    end
  end

  # GET /permissions/1
  # GET /permissions/1.xml
  def show
    @permission = Permission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @permission }
    end
  end

  # GET /permissions/new
  # GET /permissions/new.xml
  def new
    @permission = Permission.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @permission }
    end
  end

  # GET /permissions/1/edit
  def edit
    @permission = Permission.find(params[:id])
  end

  # POST /permissions
  # POST /permissions.xml
  def create
    #@permission = Permission.new(params[:permission])
    logger.info params[:permission]
    @permission = @pad.permissions.create(params[:permission])

    logger.info "@permission object is: "
    logger.info @permission

    respond_to do |format|
      if @permission.save
        format.html { redirect_to(pad_permissions_path(@pad), :notice => 'Permission was successfully created.') }
        format.xml  { render :xml => pad_permissions_path(@pad), :status => :created, :location => @permission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /permissions/1
  # PUT /permissions/1.xml
  def update
    @permission = Permission.find(params[:id])

    respond_to do |format|
      if @permission.update_attributes(params[:permission])
        format.html { redirect_to(@permission, :notice => 'Permission was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.xml
  def destroy
    @permission = Permission.find(params[:id])
    @permission.destroy

    respond_to do |format|
      format.html { redirect_to(permissions_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    def init_pad
      @pads = session[:organization].pads
      @pad = session[:organization].pads.find(params[:pad_id])
      
      @tabs = @pad.tab_counts
      @selected_tab = :permission
    end  
end
