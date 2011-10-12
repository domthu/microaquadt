require 'test_helper'

class TaxesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tax" do
    assert_difference('Tax.count') do
      post :create, :tax => { }
    end

    assert_redirected_to tax_path(assigns(:tax))
  end

  test "should show tax" do
    get :show, :id => taxes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => taxes(:one).to_param
    assert_response :success
  end

  test "should update tax" do
    put :update, :id => taxes(:one).to_param, :tax => { }
    assert_redirected_to tax_path(assigns(:tax))
  end

  test "should destroy tax" do
    assert_difference('Tax.count', -1) do
      delete :destroy, :id => taxes(:one).to_param
    end

    assert_redirected_to taxes_path
  end
end
