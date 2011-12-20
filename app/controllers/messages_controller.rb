class MessagesController < ApplicationController
  before_filter :load_pads
  layout "pads"

  # GET /messages
  # GET /messages.xml
  def index
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.xml
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.create(:body => params[:message][:body], :user_id => session[:user_id], :user_name => session[:user_name])

    #logger.info 'PARAMS@@@@@@@@@@@'
    #logger.info params[:message_body]

    respond_to do |format|
      if @message.save

        desc = @conversation.topic + ": \"" + @message.body + "\""
        add_event( EVENT_NEW_MESSAGE, desc[0,150], EVENTSOURCE_USER, session[:user_id], session[:user_name], nil)

        #MessageMailer.welcome_email(current_user).deliver

        format.html { redirect_to(pad_conversations_path(@pad), :notice => 'Message was successfully created.') }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.xml
  def destroy
    @message = Messages.find(params[:id])
    @message.destroy
  end
  
  private
    def load_pads
      @pads = session[:organization].pads
      @pad = Pad.find(params[:pad_id])
    end  
end
