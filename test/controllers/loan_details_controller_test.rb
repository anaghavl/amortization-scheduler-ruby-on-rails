require 'test_helper'

class LoanDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loan_detail = loan_details(:one)
  end

  test "should get index" do
    get loan_details_url
    assert_response :success
  end

  test "should get new" do
    get new_loan_detail_url
    assert_response :success
  end

  test "should create loan_detail" do
    assert_difference('LoanDetail.count') do
      post loan_details_url, params: { loan_detail: {  interest: @loan_detail. interest, loan_amount: @loan_detail.loan_amount, request_date: @loan_detail.request_date, term: @loan_detail.term } }
    end

    assert_redirected_to loan_detail_url(LoanDetail.last)
  end

  test "should show loan_detail" do
    get loan_detail_url(@loan_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_loan_detail_url(@loan_detail)
    assert_response :success
  end

  test "should update loan_detail" do
    patch loan_detail_url(@loan_detail), params: { loan_detail: {  interest: @loan_detail. interest, loan_amount: @loan_detail.loan_amount, request_date: @loan_detail.request_date, term: @loan_detail.term } }
    assert_redirected_to loan_detail_url(@loan_detail)
  end

  test "should destroy loan_detail" do
    assert_difference('LoanDetail.count', -1) do
      delete loan_detail_url(@loan_detail)
    end

    assert_redirected_to loan_details_url
  end
end
