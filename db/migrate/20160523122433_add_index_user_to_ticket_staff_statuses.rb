class AddIndexUserToTicketStaffStatuses < ActiveRecord::Migration
  def change
  	add_index :ticket_staff_statuses, :user_id
  end
end
