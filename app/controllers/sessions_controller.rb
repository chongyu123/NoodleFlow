class SessionsController < ApplicationController
  skip_before_filter :validate_user
  
  def new
    subdomain_name = request.subdomains.last
    subdomain_name = 'demo' if subdomain_name.nil? 
    @organization = Organization.find_by_subdomain(subdomain_name)
    if @organization.nil?
      redirect_to '/404.html'
    end 
  end

  def create  
    subdomain_name = request.subdomains.last
    subdomain_name = 'demo' if subdomain_name.nil? 
    user = User.authenticate(subdomain_name, params[:email].downcase, params[:password])
    @organization = Organization.find_by_subdomain(subdomain_name)

    if user  
      session[:organization] = @organization
      session[:user_id] = user.id  
      session[:user_name] = user.user_name
      
      redirect_to pads_path, :notice => "Logged in!"  
    else  
      flash.now.alert = "Invalid email or password"
      render "new"
    end  
  end 
  
  def destroy  
    session[:organization] = nil;
    session[:user_id] = nil
    session[:user_name] = nil;
    reset_session
    redirect_to root_url 
  end
  
end
