class TicketReply < ActiveRecord::Base
	attr_accessor :current_user#,:staff_replY_time,:customer_reply_time
	belongs_to :ticket
	belongs_to :staff, :class_name=>'User',:foreign_key=>'staff_id'
	has_one :ticket_reply_time
	after_save :time
	# validates :staff_reply,length: { minimum: 1,message: "Must contain minimum of 1 character" }
	# validates :customer_reply,length: { minimum: 1, message: "Must contain minimum of 1 character" }

    def time
    	current_user = self.current_user
    	@reply = self.ticket_reply_time
    	if  @reply.nil?  
    		if current_user.role == 'Staff'   
    			self.create_ticket_reply_time(:staff_reply_time=>Time.now)
            else 
    			self.create_ticket_reply_time(:customer_reply_time=>Time.now)
            end
        else
        	if  current_user.role == 'Staff'   
            	 self.ticket_reply_time.update(:staff_reply_time=>Time.now)
        	    
            else
            	self.ticket_reply_time.update(:customer_reply_time=>Time.now)
        	end
        end
    end 
end
