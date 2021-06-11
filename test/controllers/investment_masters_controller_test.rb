require 'test_helper'

class InvestmentMastersControllerTest < ActionController::TestCase
  setup do
    @investment_master = investment_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:investment_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create investment_master" do
    assert_difference('InvestmentMaster.count') do
      post :create, investment_master: { amount_invested: @investment_master.amount_invested, end_date: @investment_master.end_date, start_date: @investment_master.start_date, status: @investment_master.status, transaction_code: @investment_master.transaction_code, user_id: @investment_master.user_id }
    end

    assert_redirected_to investment_master_path(assigns(:investment_master))
  end

  test "should show investment_master" do
    get :show, id: @investment_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @investment_master
    assert_response :success
  end

  test "should update investment_master" do
    patch :update, id: @investment_master, investment_master: { amount_invested: @investment_master.amount_invested, end_date: @investment_master.end_date, start_date: @investment_master.start_date, status: @investment_master.status, transaction_code: @investment_master.transaction_code, user_id: @investment_master.user_id }
    assert_redirected_to investment_master_path(assigns(:investment_master))
  end

  test "should destroy investment_master" do
    assert_difference('InvestmentMaster.count', -1) do
      delete :destroy, id: @investment_master
    end

    assert_redirected_to investment_masters_path
  end
end
