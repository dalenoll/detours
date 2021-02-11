class AdminController < ApplicationController
  def login
    if request.post?
      user = User.authenticate(params[:username],params[:password])
      if user
        session[:userid] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :controller => "detours", :action => "index"} )
      else
        flash.now[:notice] = "Invalid Username or Password"
      end
    end
  end

  def logout
    session[:userid] = nil
    session[:original_uri] = nil
    reset_session
    flash[:notice] = "Logged Out"
    redirect_to( :controller => "detours", :action => "index" )
  end

  def index
  end

end
