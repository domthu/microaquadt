require 'test_helper'

class SamplingSitesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sampling_sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sampling_site" do
    assert_difference('SamplingSite.count') do
      post :create, :sampling_site => { }
    end

    assert_redirected_to sampling_site_path(assigns(:sampling_site))
  end

  test "should show sampling_site" do
    get :show, :id => sampling_sites(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sampling_sites(:one).to_param
    assert_response :success
  end

  test "should update sampling_site" do
    put :update, :id => sampling_sites(:one).to_param, :sampling_site => { }
    assert_redirected_to sampling_site_path(assigns(:sampling_site))
  end

  test "should destroy sampling_site" do
    assert_difference('SamplingSite.count', -1) do
      delete :destroy, :id => sampling_sites(:one).to_param
    end

    assert_redirected_to sampling_sites_path
  end
end
