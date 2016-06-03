class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # helper_method :current_user
  include Pundit 
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_filter :authenticate_user!
  layout :admin_layout
  # def user_exist
  #   if current_user.nil?
  #     flash[:notice] = "Please login"
  #     redirect_to new_user_session_path
  #   end  
  # end  
  
  def admin_layout
    if current_user.nil?
      "login"  
    elsif current_user.role == 'Admin' || current_user.role == 'Staff'
      "admin"
    else
      "customer"
    end
  end 
  
  private

  def user_not_authorized
    flash[:notice] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
   
end
