class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :validate_user

  helper_method :current_user  
  Time.zone = "Tijuana"
  
  
  #Event types
  EVENT_NEW_PAD = 0
  EVENT_UPDATE_PAD = 1
  EVENT_DELETE_PAD = 2
  EVENT_NEW_PAGE = 10
  EVENT_UPDATE_PAGE = 11
  EVENT_DELETE_PAGE = 12
  EVENT_NEW_MESSAGE = 20
  EVENT_UPDATE_MESSAGE = 21
  EVENT_DELETE_MESSAGE = 22
  EVENT_NEW_CONVERSATION = 30
  EVENT_DELETE_CONVERSATION = 31

  #Event source types
  EVENTSOURCE_USER = 0
  EVENTSOURCE_PAD = 1


  private

  # determine the user account based on the subdomain
  # ex) demo.myapp.com is set to 'demo' account
  def set_current_account
    @current_account = request.subdomains.last
    @current_account = 'demo' if @current_account.nil? 
  end

  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end  


  def add_event(event_type, description, source_type, source_id, source_name, link)

    pre_description = case event_type
      when EVENT_NEW_PAD
        ' added a new pad, '
      when EVENT_UPDATE_PAD
        ' updated a pad, '
      when EVENT_DELETE_PAD
        ' deleted a pad, '
      when EVENT_NEW_PAGE
        ' added a new page, '
      when EVENT_UPDATE_PAGE
        ' updated a page, '
      when EVENT_DELETE_PAGE
        ' deleted a page, '
      when EVENT_NEW_CONVERSATION
        ' started a new conversation, '
      when EVENT_DELETE_CONVERSATION
        ' deleted a conversation, '
      when EVENT_NEW_MESSAGE
        ' added a new message to conversation, '
        #when EVENT_UPDATE_MESSAGE
        #when EVENT_DELETE_MESSAGE
      end

    if description.size >= 150 
      description = description + "..."
    end
    event = session[:organization].events.create
    event.event_type = event_type
    event.description = pre_description + description
    event.source_type = source_type
    event.source_id = source_id
    event.source_name = source_name
    event.link = link
    
    if event.save
      ApplicationMailer.delay.notify_event(pre_description, event)
   end 
  end
  
  #def send_message(pre_description, event)
  #    ApplicationMailer.notify_event(pre_description, event).deliver
  #end
  
  def validate_user
    #add skip_before_filter :validate_user to escape subclasses that do not need authentication
    
    # first, check the subdomain has not changed since the login
=begin
    current_account = request.subdomains.last
    current_account = 'demo' if current_account.nil? 
    logger.info "CURRENT_ACCOUNT:" + current_account
    logger.info session[:account]
    if (session[:account] != current_account)
      redirect_to root_url, :notice => "Please login"
    end
=end    

    # now, check that user is validated
    if (session[:user_id] == nil)
      #logger.info "REDIRECTING TO ROOT"
      redirect_to root_url, :notice => "Please login"
    end
  end

end
