class AddStaffIdToTicketReplies < ActiveRecord::Migration
  def change
  	add_column :ticket_replies,:staff_id,:integer
  	add_index :ticket_replies,:staff_id
  end
end
