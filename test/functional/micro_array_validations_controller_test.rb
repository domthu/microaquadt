require 'test_helper'

class MicroArrayValidationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:micro_array_validations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create micro_array_validation" do
    assert_difference('MicroArrayValidation.count') do
      post :create, :micro_array_validation => { }
    end

    assert_redirected_to micro_array_validation_path(assigns(:micro_array_validation))
  end

  test "should show micro_array_validation" do
    get :show, :id => micro_array_validations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => micro_array_validations(:one).to_param
    assert_response :success
  end

  test "should update micro_array_validation" do
    put :update, :id => micro_array_validations(:one).to_param, :micro_array_validation => { }
    assert_redirected_to micro_array_validation_path(assigns(:micro_array_validation))
  end

  test "should destroy micro_array_validation" do
    assert_difference('MicroArrayValidation.count', -1) do
      delete :destroy, :id => micro_array_validations(:one).to_param
    end

    assert_redirected_to micro_array_validations_path
  end
end
