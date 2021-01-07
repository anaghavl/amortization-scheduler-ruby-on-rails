Rails.application.routes.draw do

  resources :loan_details, only: [:new, :index, :create] do
    member do
      get 'calculate_amortization_schedule'
    end
  end
  
  root 'loan_details#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
