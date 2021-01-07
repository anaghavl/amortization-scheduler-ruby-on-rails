class CreateLoanDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :loan_details do |t|
      t.float :interest
      t.integer :term
      t.float :loan_amount
      t.date :request_date

      t.timestamps
    end
  end
end
