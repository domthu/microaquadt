require 'test_helper'

class NucleicAcidTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nucleic_acid_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nucleic_acid_type" do
    assert_difference('NucleicAcidType.count') do
      post :create, :nucleic_acid_type => { }
    end

    assert_redirected_to nucleic_acid_type_path(assigns(:nucleic_acid_type))
  end

  test "should show nucleic_acid_type" do
    get :show, :id => nucleic_acid_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => nucleic_acid_types(:one).to_param
    assert_response :success
  end

  test "should update nucleic_acid_type" do
    put :update, :id => nucleic_acid_types(:one).to_param, :nucleic_acid_type => { }
    assert_redirected_to nucleic_acid_type_path(assigns(:nucleic_acid_type))
  end

  test "should destroy nucleic_acid_type" do
    assert_difference('NucleicAcidType.count', -1) do
      delete :destroy, :id => nucleic_acid_types(:one).to_param
    end

    assert_redirected_to nucleic_acid_types_path
  end
end
