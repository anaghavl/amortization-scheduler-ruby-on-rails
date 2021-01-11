require 'rails_helper'

RSpec.describe LoanDetailsController, type: :controller do
  describe '#new' do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#index' do
    before do
      get :index
    end
    it 'redirects to new' do
      expect(response).to redirect_to 'http://test.host/loan_details/new'
    end
  end

  describe '#create' do
    let(:params) { attributes_for(:loan_detail) }

    it 'creates new loan detail' do
      expect do
        post :create, params: { loan_detail: params }
      end.to change(LoanDetail, :count).by(1)
    end

    it 'redirects to amortization schedule page when loan detail is created' do
      post :create, params: { loan_detail: params }
      loan_details = LoanDetail.last
      expect(response).to redirect_to calculate_amortization_schedule_loan_detail_path(loan_details)
    end
  end

  describe '#calculate_amortization_schedule' do
    let(:loan_detail) { create(:loan_detail) }

    it 'calls amortization schedule method' do
      expect_any_instance_of(LoanDetail).to receive(:amortization_schedule) { 'something' }
      get :calculate_amortization_schedule, params: { id: loan_detail.id }
      expect(assigns(:amortization_schedule)).to eq('something')
    end

    it 'renders calculate amortization schedule' do
      response = get :calculate_amortization_schedule, params: { id: loan_detail.id }
      expect(response).to render_template :calculate_amortization_schedule
    end
  end
end
