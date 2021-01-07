require './lib/calculate_amortization_schedule.rb'

class LoanDetail < ApplicationRecord

  validates :interest, presence:  true, numericality: { greater_than: 0 }
  validates :loan_amount, presence: true, numericality: { greater_than: 0 }
  validates :term, presence: true, numericality: { greater_than: 0 }
  validates :request_date, presence: true

  def amortization_schedule
    CalculateAmortizationSchedule.new(self).call
  end
end
