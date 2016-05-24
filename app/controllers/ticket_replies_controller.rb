class TicketRepliesController < ApplicationController
	
	before_filter :find_ticket,:only=>[:new_staff_reply,:new_customer_reply,:create_staff_reply,:create_customer_reply]
	layout :admin_layout
	
	def new_staff_reply
		@ticket_reply = @ticket.ticket_replies.last
	    if	@ticket_reply.nil?
	    	@ticket_reply = @ticket.ticket_replies.build
	    else	
			if @ticket_reply.staff_reply.nil?	
				@ticket_reply = @ticket.ticket_replies.build
			end
		end	
    end
    
    def create_staff_reply 
    	@ticket_reply = @ticket.ticket_replies.last
    	@user = @ticket.user
    	if	@ticket_reply.nil?
	    	@ticket_reply = @ticket.ticket_replies.build(ticket_reply_params)
	        @ticket_reply.current_user = current_user
	        if @ticket_reply.save
	           TicketNotifier.staff_reply(@user,@ticket,@ticket_reply.staff_reply).deliver_later 
				redirect_to :back
			else
				flash[:notice] = "An error has occured"
			    redirect_to :back
			end   
	    elsif !@ticket_reply.staff_reply.nil? && !@ticket_reply.customer_reply.nil?
	        @ticket_reply = @ticket.ticket_replies.build(ticket_reply_params)
	        @ticket_reply.current_user = current_user
	        if @ticket_reply.save
	        	TicketNotifier.staff_reply(@user,@ticket,@ticket_reply.staff_reply).deliver_later
				redirect_to :back
			else
				flash[:notice] = "An error has occured"
			    redirect_to :back
			end 
	    else	
			if @ticket_reply.customer_reply.nil?
				@ticket_reply = @ticket.ticket_replies.build(ticket_reply_params)
				@ticket_reply.current_user = current_user
				if @ticket_reply.save
					TicketNotifier.staff_reply(@user,@ticket,@ticket_reply.staff_reply).deliver_later
					redirect_to :back
				else
					flash[:notice] = "An error has occured"
			    	redirect_to :back
				end    	
			else
				@ticket_reply.current_user = current_user
				if @ticket_reply.update(ticket_reply_params)
					TicketNotifier.staff_reply(@user,@ticket,@ticket_reply.staff_reply).deliver_later
					redirect_to :back
				else
					flash[:notice] = "An error has occured"
			    	redirect_to :back
				end
			end	  	
    	end
    end
    
    def new_customer_reply
		@ticket_reply = @ticket.ticket_replies.last
	    if	@ticket_reply.nil?
	    	@ticket_reply = @ticket.ticket_replies.build
	    else	
			if @ticket_reply.staff_reply.nil?	
				@ticket_reply = @ticket.ticket_replies.build
			end
		end		
    end
    
    def create_customer_reply 
    	@ticket_reply = @ticket.ticket_replies.last
    	if	@ticket_reply.nil?
	    	@ticket_reply = @ticket.ticket_replies.build(ticket_reply_params)
	        @ticket_reply.current_user = current_user
	        if @ticket_reply.save
				redirect_to :back
			else
				flash[:notice] = "An error has occured"
			    redirect_to :back
			end   
	    else	
			if @ticket_reply.staff_reply.nil?
				@ticket_reply = @ticket.ticket_replies.build(ticket_reply_params)
				@ticket_reply.current_user = current_user
				if @ticket_reply.save
					redirect_to :back
				else
					flash[:notice] = "An error has occured"
			    	redirect_to :back
				end    	
			elsif !@ticket_reply.staff_reply.nil? && !@ticket_reply.customer_reply.nil?
			    @ticket_reply = @ticket.ticket_replies.build(ticket_reply_params)
				@ticket_reply.current_user = current_user
				if @ticket_reply.save
					redirect_to :back
				else
					flash[:notice] = "An error has occured"
			    	redirect_to :back
				end  
			else
				@ticket_reply.current_user = current_user
				if @ticket_reply.update(ticket_reply_params)
					redirect_to :back
				else
					flash[:notice] = "An error has occured"
			    	redirect_to :back
				end
			end	  	
    	end
    end		    
    def find_ticket
    	@ticket = Ticket.find(params[:id].to_i)
    end	
    
    private

    def ticket_reply_params
    	params.require(:ticket_reply).permit(:customer_reply,:staff_reply,:staff_id)
    end	

end    
    	