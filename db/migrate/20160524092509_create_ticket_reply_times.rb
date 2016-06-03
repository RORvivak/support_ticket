class CreateTicketReplyTimes < ActiveRecord::Migration
  def change
    create_table :ticket_reply_times do |t|
      t.integer :ticket_reply_id
      t.datetime :staff_reply_time
      t.datetime :customer_reply_time

      t.timestamps null: false
    end
  end
end
