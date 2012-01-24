require 'test_helper'

class FilterSamplePreparationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:filter_sample_preparations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create filter_sample_preparation" do
    assert_difference('FilterSamplePreparation.count') do
      post :create, :filter_sample_preparation => { }
    end

    assert_redirected_to filter_sample_preparation_path(assigns(:filter_sample_preparation))
  end

  test "should show filter_sample_preparation" do
    get :show, :id => filter_sample_preparations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => filter_sample_preparations(:one).to_param
    assert_response :success
  end

  test "should update filter_sample_preparation" do
    put :update, :id => filter_sample_preparations(:one).to_param, :filter_sample_preparation => { }
    assert_redirected_to filter_sample_preparation_path(assigns(:filter_sample_preparation))
  end

  test "should destroy filter_sample_preparation" do
    assert_difference('FilterSamplePreparation.count', -1) do
      delete :destroy, :id => filter_sample_preparations(:one).to_param
    end

    assert_redirected_to filter_sample_preparations_path
  end
end
