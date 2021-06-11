require 'test_helper'

class PaymentTablesControllerTest < ActionController::TestCase
  setup do
    @payment_table = payment_tables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_table" do
    assert_difference('PaymentTable.count') do
      post :create, payment_table: { admin_profit: @payment_table.admin_profit, client_profit: @payment_table.client_profit, investment_master_code: @payment_table.investment_master_code, referer_profit: @payment_table.referer_profit, referer_user_id: @payment_table.referer_user_id, status: @payment_table.status, user_id: @payment_table.user_id }
    end

    assert_redirected_to payment_table_path(assigns(:payment_table))
  end

  test "should show payment_table" do
    get :show, id: @payment_table
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_table
    assert_response :success
  end

  test "should update payment_table" do
    patch :update, id: @payment_table, payment_table: { admin_profit: @payment_table.admin_profit, client_profit: @payment_table.client_profit, investment_master_code: @payment_table.investment_master_code, referer_profit: @payment_table.referer_profit, referer_user_id: @payment_table.referer_user_id, status: @payment_table.status, user_id: @payment_table.user_id }
    assert_redirected_to payment_table_path(assigns(:payment_table))
  end

  test "should destroy payment_table" do
    assert_difference('PaymentTable.count', -1) do
      delete :destroy, id: @payment_table
    end

    assert_redirected_to payment_tables_path
  end
end
