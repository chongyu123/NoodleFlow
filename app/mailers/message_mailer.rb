class MessageMailer < ActionMailer::Base
  default :from => "admin@artnight.net"
  
  def welcome_email(user)
    @user = user
    mail(:to => user.email,
    :subject => "Welcome to BeerGarden")
  end
end
