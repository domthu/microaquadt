require 'test_helper'

class WfiltersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wfilters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wfilter" do
    assert_difference('Wfilter.count') do
      post :create, :wfilter => { }
    end

    assert_redirected_to wfilter_path(assigns(:wfilter))
  end

  test "should show wfilter" do
    get :show, :id => wfilters(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wfilters(:one).to_param
    assert_response :success
  end

  test "should update wfilter" do
    put :update, :id => wfilters(:one).to_param, :wfilter => { }
    assert_redirected_to wfilter_path(assigns(:wfilter))
  end

  test "should destroy wfilter" do
    assert_difference('Wfilter.count', -1) do
      delete :destroy, :id => wfilters(:one).to_param
    end

    assert_redirected_to wfilters_path
  end
end
