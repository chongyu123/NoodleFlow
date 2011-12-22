class UsersController < ApplicationController
  skip_before_filter :validate_user

  def new
    @user = User.new
  end
  
  def create
    @user = session[:organization].users.create(params[:user])
    @user.email.downcase!
    @user.image_name = 'user.jpg'
    
    logger.info @user
    logger.info params[:user]
    
    if @user.save  
      redirect_to root_url, :notice => "Signed up!"  
    else  
      render "new"  
    end  
  end  
  
end
