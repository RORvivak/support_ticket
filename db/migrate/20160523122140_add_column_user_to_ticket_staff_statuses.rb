class AddColumnUserToTicketStaffStatuses < ActiveRecord::Migration
  def change
  	add_column :ticket_staff_statuses, :user_id, :integer
  end
end
