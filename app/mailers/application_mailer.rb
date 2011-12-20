class ApplicationMailer < ActionMailer::Base
  default :from => "admin@artnight.net"
  
  def notify_event(pre_description, event)
    @user_name = event.source_name
    @description = event.description
    mail(:to => 'chong@yustreet.com',
         :subject => @user_name + pre_description)
  end
end
