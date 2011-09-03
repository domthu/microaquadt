require 'test_helper'

class PartnerPeopleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:partner_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create partner_person" do
    assert_difference('PartnerPerson.count') do
      post :create, :partner_person => { }
    end

    assert_redirected_to partner_person_path(assigns(:partner_person))
  end

  test "should show partner_person" do
    get :show, :id => partner_people(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => partner_people(:one).to_param
    assert_response :success
  end

  test "should update partner_person" do
    put :update, :id => partner_people(:one).to_param, :partner_person => { }
    assert_redirected_to partner_person_path(assigns(:partner_person))
  end

  test "should destroy partner_person" do
    assert_difference('PartnerPerson.count', -1) do
      delete :destroy, :id => partner_people(:one).to_param
    end

    assert_redirected_to partner_people_path
  end
end
