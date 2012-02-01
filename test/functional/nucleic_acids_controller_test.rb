require 'test_helper'

class NucleicAcidsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nucleic_acids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nucleic_acid" do
    assert_difference('NucleicAcid.count') do
      post :create, :nucleic_acid => { }
    end

    assert_redirected_to nucleic_acid_path(assigns(:nucleic_acid))
  end

  test "should show nucleic_acid" do
    get :show, :id => nucleic_acids(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => nucleic_acids(:one).to_param
    assert_response :success
  end

  test "should update nucleic_acid" do
    put :update, :id => nucleic_acids(:one).to_param, :nucleic_acid => { }
    assert_redirected_to nucleic_acid_path(assigns(:nucleic_acid))
  end

  test "should destroy nucleic_acid" do
    assert_difference('NucleicAcid.count', -1) do
      delete :destroy, :id => nucleic_acids(:one).to_param
    end

    assert_redirected_to nucleic_acids_path
  end
end
