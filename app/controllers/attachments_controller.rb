class AttachmentsController < ApplicationController
  before_filter :init_pad
  layout "pads"

  # GET /attachments
  # GET /attachments.xml
  def index
    @attachments = @pad.attachments
    @attachment = @pad.attachments.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attachments }
    end
  end

  # GET /attachments/1
  # GET /attachments/1.xml
  def show
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attachment }
    end
  end

  # GET /attachments/new
  # GET /attachments/new.xml
  def new
    @attachment = Attachment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @attachment }
    end
  end

  # GET /attachments/1/edit
  def edit
    @attachment = Attachment.find(params[:id])
  end

  # POST /attachments
  # POST /attachments.xml
  def create

    uploaded_io = params[:new_file]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
      file.write(uploaded_io.read)
    end

    @attachment = @pad.attachments.new(params[:attachment])
    @attachment.name = uploaded_io.original_filename;

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to(pad_attachments_path(@pad), :notice => 'Attachment was successfully created.') }
        format.xml  { render :xml => @attachment, :status => :created, :location => @attachment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /attachments/1
  # PUT /attachments/1.xml
  def update
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      if @attachment.update_attributes(params[:attachment])
        format.html { redirect_to(@attachment, :notice => 'Attachment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.xml
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to(pad_attachments_path(@pad)) }
      format.xml  { head :ok }
    end
  end
  
  private
    def init_pad
      @pads = session[:organization].pads
      @pad = session[:organization].pads.find(params[:pad_id])
    
      @tabs = @pad.tab_counts
      @selected_tab = :attachment
    end  
end
