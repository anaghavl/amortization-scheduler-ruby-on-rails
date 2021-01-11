require './lib/calculate_amortization_schedule.rb'

class LoanDetail < ApplicationRecord

  TYPE_OF_LOAN = ["Regular loan", "Interest only duration"].freeze
  validates :interest, presence:  true, numericality: { greater_than: 0 }
  validates :loan_amount, presence: true, numericality: { greater_than: 0 }
  validates :term, presence: true, numericality: { greater_than: 0 }
  validates :request_date, presence: true
  validates :type_of_loan, presence: true, inclusion: { in: TYPE_OF_LOAN }

  def type_of_loan_select
    TYPE_OF_LOAN.each {|type|}
  end

  def amortization_schedule
    CalculateAmortizationSchedule.new(self).call
  end
end
