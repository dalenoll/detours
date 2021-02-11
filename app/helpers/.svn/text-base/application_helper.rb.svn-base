# Methods added to this helper will be available to all templates in the application.
require "admin_helper"
module ApplicationHelper

  include AdminHelper

  def user_name
    user = User.find_by_id(session[:userid])
    user.username if user
  end

  def full_name
    user = User.find_by_id(session[:userid])
    user.full_name if user
  end

end
