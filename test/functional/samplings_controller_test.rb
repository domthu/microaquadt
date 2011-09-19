require 'test_helper'

class SamplingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:samplings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sampling" do
    assert_difference('Sampling.count') do
      post :create, :sampling => { }
    end

    assert_redirected_to sampling_path(assigns(:sampling))
  end

  test "should show sampling" do
    get :show, :id => samplings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => samplings(:one).to_param
    assert_response :success
  end

  test "should update sampling" do
    put :update, :id => samplings(:one).to_param, :sampling => { }
    assert_redirected_to sampling_path(assigns(:sampling))
  end

  test "should destroy sampling" do
    assert_difference('Sampling.count', -1) do
      delete :destroy, :id => samplings(:one).to_param
    end

    assert_redirected_to samplings_path
  end
end
