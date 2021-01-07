class LoanDetailsController < ApplicationController

  # GET /loan_details
  def index
    redirect_to :action => :new
  end

  # GET /loan_details/new
  def new
    @loan_detail = LoanDetail.new
  end

  # POST /loan_details
  # POST /loan_details.json
  def create
    @loan_detail = LoanDetail.new(loan_detail_params)

    if @loan_detail.save
      redirect_to calculate_amortization_schedule_loan_detail_path(@loan_detail)
    else
      format.html { render :new }
      format.json { render json: @loan_detail.errors, status: :unprocessable_entity }
    end
  end

  def calculate_amortization_schedule
    @loan_detail = LoanDetail.find(params[:id])
    @amortization_schedule = @loan_detail.amortization_schedule
  end

  private

  def loan_detail_params
    params.require(:loan_detail).permit(:interest, :term, :loan_amount, :request_date)
  end
end
