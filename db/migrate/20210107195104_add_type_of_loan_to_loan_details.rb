class AddTypeOfLoanToLoanDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_details, :type_of_loan, :string
  end
end
