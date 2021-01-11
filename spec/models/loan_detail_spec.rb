require 'rails_helper'

RSpec.describe LoanDetail, type: :model do
  it { is_expected.to validate_inclusion_of(:type_of_loan).in_array(["Regular loan", "Interest only duration"]) }

  it { is_expected.to validate_numericality_of(:loan_amount).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:loan_amount).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:term).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:interest).is_greater_than(0) }

  it { is_expected.to validate_presence_of :loan_amount }
  it { is_expected.to validate_presence_of :interest }
  it { is_expected.to validate_presence_of :term }
  it { is_expected.to validate_presence_of :request_date }
  it { is_expected.to validate_presence_of :type_of_loan }

  describe 'amortization schedule' do
    let(:loan_detail) { build(:loan_detail) }
    it 'calls CalculateAmortizationSchedule service' do
      expect_any_instance_of(CalculateAmortizationSchedule).to receive(:call) { 'something' }
      expect(loan_detail.amortization_schedule).to eq('something')
    end
  end
end
