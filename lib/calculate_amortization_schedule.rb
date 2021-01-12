class CalculateAmortizationSchedule

  def initialize(loan_detail)
    @loan_detail = loan_detail
    @interest = ((@loan_detail.interest * 0.01 )/ 12) * @loan_detail.loan_amount
    @monthly_payment = calculate_monthly_payment(@loan_detail.loan_amount, @loan_detail.term)
    @principal_amount = @monthly_payment - @interest
    @start_balance = @loan_detail.loan_amount
    @end_balance = @start_balance - @principal_amount
    @amortization_schedule = []
  end

  # Check the type of loan and call appropriate function
  def call
    if(@loan_detail.type_of_loan == "Regular loan")
      amortization_schedule_regular_loan
    else
      amortization_schedule_interest_only_duration
    end
  end

  # Calculate monthly payment
  def calculate_monthly_payment(loan_amount, term)
    annual_interest = (@loan_detail.interest * 0.01 )/ 12
    (( loan_amount * annual_interest ) * (( annual_interest + 1 )**term)) / ((( annual_interest + 1 )**term ) - 1 )
  end

  private

  # Calculate the schedule for interest only duration
  def amortization_schedule_interest_only_duration
    build_initial_amortization_schedule_interest_only_duration
    build_pending_amortization_schedule
    @amortization_schedule
  end

  # Calculate the schedule for regular loan
  def amortization_schedule_regular_loan
    date = next_date(@loan_detail.request_date)
    build_amortization_schedule(date, @start_balance, @end_balance, @interest, @principal_amount, @monthly_payment)
    build_pending_amortization_schedule
    @amortization_schedule
  end

  #add rows to amortization_schedule
  def build_amortization_schedule(date, start_balance, end_balance, interest, principal, monthly_payment) 
    @amortization_schedule.push(date: date,
      start_balance: start_balance,
      end_balance: end_balance,
      interest: interest,
      principal: principal,
      monthly_payment: monthly_payment)
  end

  # Calculate the schedule for interest only duration first 3 months
  def build_initial_amortization_schedule_interest_only_duration
    3.times do
      if @amortization_schedule.blank?
        date = next_date(@loan_detail.request_date)
      else
        date = next_date(@amortization_schedule.last[:date])
      end
      build_amortization_schedule(date, @start_balance, @start_balance, @interest, 0, @interest)
    end
  end

  # Calculate the schedule for the rest of the term
  def build_pending_amortization_schedule
    if(@loan_detail.type_of_loan == "Regular loan")
      term_left = @loan_detail.term - 1
    else
      term_left = @loan_detail.term - 3
      @monthly_payment = calculate_monthly_payment(@amortization_schedule.last[:end_balance], @loan_detail.term - 3)
    end

    term_left.times do
      start_balance = @amortization_schedule.last[:end_balance]
      interest = start_balance * ((@loan_detail.interest * 0.01 )/ 12)
      principal = @monthly_payment - interest
      end_balance = start_balance - principal
      date = next_date(@amortization_schedule.last[:date])
      build_amortization_schedule(date, start_balance, end_balance, interest, principal, @monthly_payment)
    end
  end

  # Get the first of the next month
  def next_date(date)
    date.next_month.at_beginning_of_month
  end
end