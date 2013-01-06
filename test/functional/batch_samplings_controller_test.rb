require 'test_helper'

class BatchSamplingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:batch_samplings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create batch_sampling" do
    assert_difference('BatchSampling.count') do
      post :create, :batch_sampling => { }
    end

    assert_redirected_to batch_sampling_path(assigns(:batch_sampling))
  end

  test "should show batch_sampling" do
    get :show, :id => batch_samplings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => batch_samplings(:one).to_param
    assert_response :success
  end

  test "should update batch_sampling" do
    put :update, :id => batch_samplings(:one).to_param, :batch_sampling => { }
    assert_redirected_to batch_sampling_path(assigns(:batch_sampling))
  end

  test "should destroy batch_sampling" do
    assert_difference('BatchSampling.count', -1) do
      delete :destroy, :id => batch_samplings(:one).to_param
    end

    assert_redirected_to batch_samplings_path
  end
end
