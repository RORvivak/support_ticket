class AdminUserRegistrationsController < ApplicationController
	layout "admin"
	skip_before_filter :require_no_authentication 
	
	def new
  	@user = User.new 
	end	

	def create
  	@user = User.new(user_params)
  	@user.role = 'Staff'
  	if @user.save  
  	  render 'new'
  	else
  		render 'new'
  	end	
	end

	private

	def user_params
  	params.require(admin_user_registrations_new_path).permit(:first_name,:last_name,:email, :password, :password_confirmation,:department_id)
	end  

end  	