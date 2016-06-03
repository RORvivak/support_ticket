class CreateTicketChattOwners < ActiveRecord::Migration
  def change
    create_table :ticket_chatt_owners do |t|
      t.integer :user_id
      t.integer :ticket_staff_status_id

      t.timestamps null: false
    end
  end
end
