class TicketStaffStatus < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :staff,:class_name=>'User',:foreign_key=>'staff_id'
  enum :status=> [:Waiting_for_Staff_Response,:Waiting_for_Customer,:on_hold,:cancelled,:completed]
end
