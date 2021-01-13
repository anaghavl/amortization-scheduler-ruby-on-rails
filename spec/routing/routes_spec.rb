require 'rails_helper'

RSpec.describe 'loan details routes', type: :routing do
  it { expect(get('/')).to route_to('loan_details#new') }
  it { expect(post('/loan_details')).to route_to('loan_details#create') }
  it { expect(get('/loan_details/')).to route_to('loan_details#index') }
  it { expect(get('/loan_details/new/')).to route_to('loan_details#new') }
  it { expect(get('loan_details/10/calculate_amortization_schedule')).to route_to('loan_details#calculate_amortization_schedule', id: '10') }
end
