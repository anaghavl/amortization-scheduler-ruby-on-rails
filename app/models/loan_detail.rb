require './lib/calculate_amortization_schedule.rb'

class LoanDetail < ApplicationRecord

  validates :interest, presence:  true, numericality: { greater_than: 0 }
  validates :loan_amount, presence: true, numericality: { greater_than: 0 }
  validates :term, presence: true, numericality: { greater_than: 0 }
  validates :request_date, presence: true
  validates :type_of_loan, presence: true
  TYPE_OF_LOAN = ["Regular loan", "Interest only duration"]

  def type_of_loan_select
    TYPE_OF_LOAN.each {|type|}
  end

  def amortization_schedule
    CalculateAmortizationSchedule.new(self).call
  end
end
