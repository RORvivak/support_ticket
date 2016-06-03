class RenameStaffIdInUsers < ActiveRecord::Migration
  def change
  	rename_column :tickets, :customer_id, :user_id
  end
end
