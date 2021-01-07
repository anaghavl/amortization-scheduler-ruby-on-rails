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
    @type_of_loan = @loan_detail.type_of_loan
  end

  # Check the type of loan and call appropriate function
  def call
    if(@type_of_loan == "Regular loan")
      amortization_schedule_regular_loan
    else
      amortization_schedule_interest_only_duration
    end
  end

  # Calculate monthly payment
  def calculate_monthly_payment(loan_amount, term)
    (( loan_amount * @annual_interest ) * (( @annual_interest + 1 )**term)) / ((( @annual_interest + 1 )**term ) - 1 )
  end

  private

  # Calculate the schedule for the first 3 months
  def amortization_schedule_interest_only_duration
    @amortization_schedule = []
    3.times do
      if @amortization_schedule.blank?
        date = next_date(@request_date)
      else
        date = next_date(@amortization_schedule.last[:date])
      end
      @amortization_schedule.push(date: date,
        start_balance: @start_balance,
        end_balance: @start_balance,
        interest: @interest,
        principal: 0,
        monthly_payment: @interest)
    end
    amortization_schedule_interest_only_duration_pending_term
    @amortization_schedule
  end

  # Calculate the schedule for the first month
  def amortization_schedule_regular_loan
    @amortization_schedule = []

    date = next_date(@request_date)
    @amortization_schedule.push(date: date,
      start_balance: @start_balance,
      end_balance: @end_balance,
      interest: @interest,
      principal: @principal_amount,
      monthly_payment: @monthly_payment)

      amortization_schedule_regular_loan_pending_term
    @amortization_schedule
  end

  # Calculate the schedule for the rest of the term
  def amortization_schedule_interest_only_duration_pending_term
    monthly_payment = calculate_monthly_payment(@amortization_schedule.last[:end_balance], @term - 3)
    (@term - 3).times do
      start_balance = @amortization_schedule.last[:end_balance]
      interest = start_balance * @annual_interest
      principal = monthly_payment - interest
      end_balance = start_balance - principal
      date = next_date(@amortization_schedule.last[:date])
      @amortization_schedule.push(date: date,
                                  start_balance: start_balance,
                                  end_balance: end_balance,
                                  interest: interest, 
                                  principal: principal,
                                  monthly_payment: monthly_payment)
    end
  end

  # Calculate the schedule for the rest of the term
  def amortization_schedule_regular_loan_pending_term
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

  # Get the first of the next month
  def next_date(date)
    date.next_month.at_beginning_of_month
  end
end
