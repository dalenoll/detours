# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require "admin_helper"

class ApplicationController < ActionController::Base

  include AdminHelper

  before_filter :authorize, :except => [ :login, :logout ]

  helper :all # include all helpers, all the time

  session :session_key => '_mcts_detour_management_id'
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => 'fa98562a1a5ec31acae309d13abbb106'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

private

#  def authorize 
#    logger.info("AUTHORIZE:  controller = " + params[:controller] + " Action = " + params[:action] + " \n")
#    unless User.find_by_id(session[:userid])
#      flash[:notice] = "Not Logged in."
#      session[:original_uri] = request.request_uri
#      redirect_to :controller => :admin, :action => :login
#    end
#  end

  def authorize 
    if ! if_accessible(params[:controller],params[:action])
      flash[:notice] = "Not Authorized."
      session[:original_uri] = request.request_uri
      redirect_to :controller => :detours, :action => :index
    end
  end

end
