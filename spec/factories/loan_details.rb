FactoryBot.define do
  factory :loan_detail, class: "LoanDetail" do
    loan_amount 10000
    interest 10
    term 10
    request_date '05-10-2019'
    type_of_loan 'Regular loan'
  end
end
