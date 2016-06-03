module UserDashboardsHelper
	
	def chat_user(current_user)
		if current_user.role == 'Staff'
			@ticket_user_ids = current_user.staff_tickets.pluck(:user_id).compact.uniq
			@users = User.where(:id=>@ticket_user_ids)
		     # zfxdf
		elsif current_user.role == 'Customer'
		    @ticket_staff_ids = current_user.tickets.pluck(:staff_id).compact.uniq
		    @users = User.where(:id=>@ticket_staff_ids)
		end	
		# gfgf
    end

end
