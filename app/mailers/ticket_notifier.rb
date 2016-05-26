class TicketNotifier < ApplicationMailer

	def Ticket_verification_customer(user,ticket)
    	@user = user
    	@ticket = ticket
    	mail(to: @user.email, subject: 'Ticket Verification')
	end


    def Ticket_verification_staff(ticket)
    	@ticket_token = ticket.token
    	@department = ticket.department
        @department_name = @department.name 
        @staff = @department.users
        @staff.each do |s|
        	mail(to: s.email, subject: 'Ticket Verification')
        end	 	
    end	

	def staff_reply(user,ticket,reply)
		@token = ticket.token
		@ticket = Ticket
		@user = user
		@reply = reply
		mail(to: @user.email, subject: 'Ticket Reply')
	end	

end
