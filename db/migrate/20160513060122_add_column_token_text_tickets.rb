class AddColumnTokenTextTickets < ActiveRecord::Migration
  def change
  	add_column :tickets,:token,:string
  	add_index :tickets, :token
  end
end
