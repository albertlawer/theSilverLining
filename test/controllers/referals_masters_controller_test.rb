require 'test_helper'

class ReferalsMastersControllerTest < ActionController::TestCase
  setup do
    @referals_master = referals_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:referals_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create referals_master" do
    assert_difference('ReferalsMaster.count') do
      post :create, referals_master: { refered_user_id: @referals_master.refered_user_id, status: @referals_master.status, user_id: @referals_master.user_id }
    end

    assert_redirected_to referals_master_path(assigns(:referals_master))
  end

  test "should show referals_master" do
    get :show, id: @referals_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @referals_master
    assert_response :success
  end

  test "should update referals_master" do
    patch :update, id: @referals_master, referals_master: { refered_user_id: @referals_master.refered_user_id, status: @referals_master.status, user_id: @referals_master.user_id }
    assert_redirected_to referals_master_path(assigns(:referals_master))
  end

  test "should destroy referals_master" do
    assert_difference('ReferalsMaster.count', -1) do
      delete :destroy, id: @referals_master
    end

    assert_redirected_to referals_masters_path
  end
end
