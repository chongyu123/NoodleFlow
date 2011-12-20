class ConversationsController < ApplicationController
  before_filter :load_pads
  layout "pads"

# GET /conversations
  # GET /conversations.xml
  def index
    @conversations = @pad.conversations
    @message = Message.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @conversations }
    end
  end

  # GET /conversations/1
  # GET /conversations/1.xml
  def show
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @conversation }
    end
  end

  # GET /conversations/new
  # GET /conversations/new.xml
  def new
    @conversation = Conversation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @conversation }
    end
  end

  # GET /conversations/1/edit
  def edit
    @conversation = Conversation.find(params[:id])
  end

  # POST /conversations
  # POST /conversations.xml
  def create
    @conversation = @pad.conversations.create(params[:conversation])
    logger.info 'PARAMS@@@@@@@@@@@'
    logger.info params[:message_body]

    respond_to do |format|
      if @conversation.save
        @conversation.messages.create( :body => params[:message_body], :user_id => session[:user_id], :user_name => session[:user_name])

        desc = params[:conversation][:topic] + ": \"" + params[:message_body] + "\""
        add_event( EVENT_NEW_CONVERSATION, desc[0,150], EVENTSOURCE_USER, session[:user_id], session[:user_name], nil)

        format.html { redirect_to(pad_conversations_path(@pad), :notice => 'Conversation was successfully created.') }
        format.xml  { render :xml => @conversation, :status => :created, :location => @conversation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @conversation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /conversations/1
  # PUT /conversations/1.xml
  def update
    @conversation = Conversation.find(params[:id])

    # handle publish/unpublish
    if !params[:published].blank?
      if params[:published] == 'y'
        @conversation.published = true
      else
        @conversation.published = false
      end        
    end

    respond_to do |format|
      if @conversation.update_attributes(params[:conversation])
        format.html { redirect_to(pad_conversations_path(@pad), :notice => 'Conversation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conversation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.xml
  def destroy
    @conversation = Conversation.find(params[:id])

    desc = @conversation.topic
    add_event( EVENT_DELETE_CONVERSATION, desc[0,150], EVENTSOURCE_USER, session[:user_id], session[:user_name], nil)

    @conversation.destroy

    respond_to do |format|
      format.html { redirect_to(pad_conversations_path(@pad)) }
      format.xml  { head :ok }
    end
  end
  
  private
    def load_pads
      @pads = session[:organization].pads
      @pad = session[:organization].pads.find(params[:pad_id])
      
      @tabs = @pad.tab_counts
      @selected_tab = :conversation
    end  
end
