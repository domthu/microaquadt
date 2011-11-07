require 'test_helper'

class CatchmentAreasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catchment_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catchment_area" do
    assert_difference('CatchmentArea.count') do
      post :create, :catchment_area => { }
    end

    assert_redirected_to catchment_area_path(assigns(:catchment_area))
  end

  test "should show catchment_area" do
    get :show, :id => catchment_areas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => catchment_areas(:one).to_param
    assert_response :success
  end

  test "should update catchment_area" do
    put :update, :id => catchment_areas(:one).to_param, :catchment_area => { }
    assert_redirected_to catchment_area_path(assigns(:catchment_area))
  end

  test "should destroy catchment_area" do
    assert_difference('CatchmentArea.count', -1) do
      delete :destroy, :id => catchment_areas(:one).to_param
    end

    assert_redirected_to catchment_areas_path
  end
end
