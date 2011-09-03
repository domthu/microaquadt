require 'test_helper'

class GeosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geo" do
    assert_difference('Geo.count') do
      post :create, :geo => { }
    end

    assert_redirected_to geo_path(assigns(:geo))
  end

  test "should show geo" do
    get :show, :id => geos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => geos(:one).to_param
    assert_response :success
  end

  test "should update geo" do
    put :update, :id => geos(:one).to_param, :geo => { }
    assert_redirected_to geo_path(assigns(:geo))
  end

  test "should destroy geo" do
    assert_difference('Geo.count', -1) do
      delete :destroy, :id => geos(:one).to_param
    end

    assert_redirected_to geos_path
  end
end
