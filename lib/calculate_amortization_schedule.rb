class CalculateAmortizationSchedule

  def initialize(loan_detail)
    @loan_detail = loan_detail
    @annual_interest = (@loan_detail.interest * 0.01 )/ 12
    @interest = @annual_interest * @loan_detail.loan_amount
    @monthly_payment = calculate_monthly_payment(@loan_detail.loan_amount, @loan_detail.term)
    @principal_amount = @monthly_payment - @interest
    @term = @loan_detail.term
    @request_date = @loan_detail.request_date
    @start_balance = @loan_detail.loan_amount
    @end_balance = @start_balance - @principal_amount
  end

  def call
    amortization_schedule
  end

  def calculate_monthly_payment(loan_amount, term)
    (( loan_amount * @annual_interest ) * (( @annual_interest + 1 )**term)) / ((( @annual_interest + 1 )**term ) - 1 )
  end

  private

  def amortization_schedule
    @amortization_schedule = []
    date = next_date(@request_date)
    @amortization_schedule.push(date: date,
      start_balance: @start_balance,
      end_balance: @end_balance,
      interest: @interest,
      principal: @principal_amount,
      monthly_payment: @monthly_payment)

    compute_amortization_schedule_for_rest_of_months
    @amortization_schedule
  end

  def compute_amortization_schedule_for_rest_of_months
    (@term - 1).times do
      start_balance = @amortization_schedule.last[:end_balance]
      interest = start_balance * @annual_interest
      principal = @monthly_payment - interest
      end_balance = start_balance - principal
      date = next_date(@amortization_schedule.last[:date])
      @amortization_schedule.push(date: date,
                                  start_balance: start_balance,
                                  end_balance: end_balance,
                                  interest: interest, 
                                  principal: principal,
                                  monthly_payment: @monthly_payment)
    end
  end

  def next_date(date)
    date.next_month.at_beginning_of_month
  end
end
