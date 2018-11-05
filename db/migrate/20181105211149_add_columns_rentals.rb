class AddColumnsRentals < ActiveRecord::Migration[5.2]
  def change
    add_reference(:rentals, :movie, foreign_key: true)
    add_reference(:rentals, :customer, foreign_key: true)
    add_column(:rentals, :check_out, :date)
    add_column(:rentals, :due_date, :date)
    add_column(:rentals, :status, :string)
  end
end
