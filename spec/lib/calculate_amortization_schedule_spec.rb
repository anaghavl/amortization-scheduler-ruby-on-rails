require 'rails_helper'
require 'calculate_amortization_schedule'

RSpec.describe CalculateAmortizationSchedule do
  subject { described_class.new(loan_detail) }

  describe 'call calculate amortization schedule' do
    context 'When user selects regular loan' do

      let(:loan_detail) { build :loan_detail, loan_amount: 1000, term: 2, interest: 10, request_date: Date.new(2020, 01, 10), type_of_loan: "Regular loan" }

      it 'creates amortization schedule for regular loan' do
        amortization_schedule = subject.call
        expect(amortization_schedule[0][:principal].round(2)).to be_equal 497.93
        expect(amortization_schedule[0][:interest].round(2)).to be_equal 8.33
        expect(amortization_schedule[0][:start_balance].round(2)).to be_equal 1000.0
        expect(amortization_schedule[0][:end_balance].round(2)).to be_equal 502.07
        expect(amortization_schedule[0][:monthly_payment].round(2)).to be_equal 506.26
        expect(amortization_schedule[0][:date]).to eq Date.new(2020, 02, 1)

        expect(amortization_schedule[1][:principal].round(2)).to be_equal 502.07
        expect(amortization_schedule[1][:interest].round(2)).to be_equal 4.18
        expect(amortization_schedule[1][:start_balance].round(2)).to be_equal 502.07
        expect(amortization_schedule[1][:end_balance].round(2)).to be_equal 0.0
        expect(amortization_schedule[1][:monthly_payment].round(2)).to be_equal 506.26
        expect(amortization_schedule[1][:date]).to eq Date.new(2020, 03, 1)
      end
    end

    context 'When user selects Interest only duration' do

      let(:loan_detail) { build :loan_detail, loan_amount: 1000, term: 4, interest: 10, request_date: Date.new(2020, 01, 10), type_of_loan: "Interest only duration" }
      
      it 'creates amortization schedule for Interest only duration' do
        amortization_schedule = subject.call
        expect(amortization_schedule[0][:principal].round(2)).to be_equal 0
        expect(amortization_schedule[0][:interest].round(2)).to be_equal 8.33
        expect(amortization_schedule[0][:start_balance].round(2)).to be_equal 1000.0
        expect(amortization_schedule[0][:end_balance].round(2)).to be_equal 1000.0
        expect(amortization_schedule[0][:monthly_payment].round(2)).to be_equal 8.33
        expect(amortization_schedule[0][:date]).to eq Date.new(2020, 02, 1)

        expect(amortization_schedule[1][:principal].round(2)).to be_equal 0
        expect(amortization_schedule[1][:interest].round(2)).to be_equal 8.33
        expect(amortization_schedule[1][:start_balance].round(2)).to be_equal 1000.0
        expect(amortization_schedule[1][:end_balance].round(2)).to be_equal 1000.0
        expect(amortization_schedule[1][:monthly_payment].round(2)).to be_equal 8.33
        expect(amortization_schedule[1][:date]).to eq Date.new(2020, 03, 1)

        expect(amortization_schedule[2][:principal].round(2)).to be_equal 0
        expect(amortization_schedule[2][:interest].round(2)).to be_equal 8.33
        expect(amortization_schedule[2][:start_balance].round(2)).to be_equal 1000.0
        expect(amortization_schedule[2][:end_balance].round(2)).to be_equal 1000.0
        expect(amortization_schedule[2][:monthly_payment].round(2)).to be_equal 8.33
        expect(amortization_schedule[2][:date]).to eq Date.new(2020, 04, 1)


        expect(amortization_schedule[3][:principal].round(2)).to be_equal 1000.0
        expect(amortization_schedule[3][:interest].round(2)).to be_equal 8.33
        expect(amortization_schedule[3][:start_balance].round(2)).to be_equal 1000.0
        expect(amortization_schedule[3][:end_balance].round(2)).to be_equal 0.0
        expect(amortization_schedule[3][:monthly_payment].round(2)).to be_equal 1008.33
        expect(amortization_schedule[3][:date]).to eq Date.new(2020, 05, 1)
      end
    end
  end
end