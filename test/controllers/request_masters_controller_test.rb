require 'test_helper'

class RequestMastersControllerTest < ActionController::TestCase
  setup do
    @request_master = request_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:request_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request_master" do
    assert_difference('RequestMaster.count') do
      post :create, request_master: { amount: @request_master.amount, callback_status: @request_master.callback_status, customer_number: @request_master.customer_number, item_desc: @request_master.item_desc, network: @request_master.network, resp_code: @request_master.resp_code, resp_desc: @request_master.resp_desc, status: @request_master.status, trans_id: @request_master.trans_id, trans_type: @request_master.trans_type, user_id: @request_master.user_id }
    end

    assert_redirected_to request_master_path(assigns(:request_master))
  end

  test "should show request_master" do
    get :show, id: @request_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @request_master
    assert_response :success
  end

  test "should update request_master" do
    patch :update, id: @request_master, request_master: { amount: @request_master.amount, callback_status: @request_master.callback_status, customer_number: @request_master.customer_number, item_desc: @request_master.item_desc, network: @request_master.network, resp_code: @request_master.resp_code, resp_desc: @request_master.resp_desc, status: @request_master.status, trans_id: @request_master.trans_id, trans_type: @request_master.trans_type, user_id: @request_master.user_id }
    assert_redirected_to request_master_path(assigns(:request_master))
  end

  test "should destroy request_master" do
    assert_difference('RequestMaster.count', -1) do
      delete :destroy, id: @request_master
    end

    assert_redirected_to request_masters_path
  end
end
