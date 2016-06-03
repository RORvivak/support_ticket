class CreateTicketReplies < ActiveRecord::Migration
  def change
    create_table :ticket_replies do |t|
      t.string :customer_reply
      t.string :staff_reply
      t.string :ticket_id

      t.timestamps null: false
    end
  end
end
