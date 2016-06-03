class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :body
      t.integer :customer_id
      t.integer :staff_id
      t.integer :department_id

      t.timestamps null: false
    end
  end
end
