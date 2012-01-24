require 'test_helper'

class SamplingEquipmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sampling_equipments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sampling_equipment" do
    assert_difference('SamplingEquipment.count') do
      post :create, :sampling_equipment => { }
    end

    assert_redirected_to sampling_equipment_path(assigns(:sampling_equipment))
  end

  test "should show sampling_equipment" do
    get :show, :id => sampling_equipments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sampling_equipments(:one).to_param
    assert_response :success
  end

  test "should update sampling_equipment" do
    put :update, :id => sampling_equipments(:one).to_param, :sampling_equipment => { }
    assert_redirected_to sampling_equipment_path(assigns(:sampling_equipment))
  end

  test "should destroy sampling_equipment" do
    assert_difference('SamplingEquipment.count', -1) do
      delete :destroy, :id => sampling_equipments(:one).to_param
    end

    assert_redirected_to sampling_equipments_path
  end
end
