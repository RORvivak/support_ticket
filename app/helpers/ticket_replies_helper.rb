module TicketRepliesHelper
	def all_reply(ticket)
		@ticket_reply_all = ticket.ticket_replies
		@user = TicketReply.includes(:staff).where(:ticket_id=>ticket.id).pluck(:email)
        @customer = ticket.user.email + ':'
		# @staff = 'staff_t@gmail.com :'
	end

	def ticket_customer_reply_time(t)
    	return '('+ t.ticket_reply_time.customer_reply_time.strftime("%d-%m-%Y %H:%M:%S")+')'
	end

	def ticket_staff_reply_time(t)
    	return '('+ t.ticket_reply_time.staff_reply_time.strftime("%d-%m-%Y %H:%M:%S")+')'
	end

    def chat_positions(t)
   		@position = 0
   		if t.ticket_reply_time.staff_reply_time < t.ticket_reply_time.customer_reply_time
     		@position = 1
     	end	
   end 

end
