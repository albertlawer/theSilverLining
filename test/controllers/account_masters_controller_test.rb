require 'test_helper'

class AccountMastersControllerTest < ActionController::TestCase
  setup do
    @account_master = account_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_master" do
    assert_difference('AccountMaster.count') do
      post :create, account_master: { avaliable_balance: @account_master.avaliable_balance, status: @account_master.status, user_id: @account_master.user_id }
    end

    assert_redirected_to account_master_path(assigns(:account_master))
  end

  test "should show account_master" do
    get :show, id: @account_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account_master
    assert_response :success
  end

  test "should update account_master" do
    patch :update, id: @account_master, account_master: { avaliable_balance: @account_master.avaliable_balance, status: @account_master.status, user_id: @account_master.user_id }
    assert_redirected_to account_master_path(assigns(:account_master))
  end

  test "should destroy account_master" do
    assert_difference('AccountMaster.count', -1) do
      delete :destroy, id: @account_master
    end

    assert_redirected_to account_masters_path
  end
end
