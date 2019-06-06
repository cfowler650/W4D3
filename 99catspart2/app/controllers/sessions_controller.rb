class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )

    @user.reset_session_token! unless nil
     
    redirect_to cats_url
    
  end 

  def log_in!
    @current_user.reset_session_token! if @current_user = nil
    session[:session_token] = @current_user.session_token 
    redirect_to cats_url
   
  end

  def log_out!
    @current_user.reset_session_token! if current_user
    session[:session_token] = nil
    @current_user = nil
  end  

  def destroy
    @current_user = current_user
    @current_user.delete!
    log_out!
    redirect_to new_session_url
  end 

end
