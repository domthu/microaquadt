require 'test_helper'

class WaterSamplesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:water_samples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create water_sample" do
    assert_difference('WaterSample.count') do
      post :create, :water_sample => { }
    end

    assert_redirected_to water_sample_path(assigns(:water_sample))
  end

  test "should show water_sample" do
    get :show, :id => water_samples(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => water_samples(:one).to_param
    assert_response :success
  end

  test "should update water_sample" do
    put :update, :id => water_samples(:one).to_param, :water_sample => { }
    assert_redirected_to water_sample_path(assigns(:water_sample))
  end

  test "should destroy water_sample" do
    assert_difference('WaterSample.count', -1) do
      delete :destroy, :id => water_samples(:one).to_param
    end

    assert_redirected_to water_samples_path
  end
end
