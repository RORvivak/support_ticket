class CreateTicketStaffStatuses < ActiveRecord::Migration
  def change
    create_table :ticket_staff_statuses do |t|
      t.integer :ticket_id
      t.integer :staff_id
      t.integer :status

      t.timestamps null: false
    end
  end
end
