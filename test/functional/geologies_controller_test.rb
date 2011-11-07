require 'test_helper'

class GeologiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geologies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geology" do
    assert_difference('Geology.count') do
      post :create, :geology => { }
    end

    assert_redirected_to geology_path(assigns(:geology))
  end

  test "should show geology" do
    get :show, :id => geologies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => geologies(:one).to_param
    assert_response :success
  end

  test "should update geology" do
    put :update, :id => geologies(:one).to_param, :geology => { }
    assert_redirected_to geology_path(assigns(:geology))
  end

  test "should destroy geology" do
    assert_difference('Geology.count', -1) do
      delete :destroy, :id => geologies(:one).to_param
    end

    assert_redirected_to geologies_path
  end
end
