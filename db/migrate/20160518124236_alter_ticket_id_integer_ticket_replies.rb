class AlterTicketIdIntegerTicketReplies < ActiveRecord::Migration
  def change
  	change_column :ticket_replies, :ticket_id, :integer
  end
end
