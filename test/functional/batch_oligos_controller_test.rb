require 'test_helper'

class BatchOligosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:batch_oligos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create batch_oligo" do
    assert_difference('BatchOligo.count') do
      post :create, :batch_oligo => { }
    end

    assert_redirected_to batch_oligo_path(assigns(:batch_oligo))
  end

  test "should show batch_oligo" do
    get :show, :id => batch_oligos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => batch_oligos(:one).to_param
    assert_response :success
  end

  test "should update batch_oligo" do
    put :update, :id => batch_oligos(:one).to_param, :batch_oligo => { }
    assert_redirected_to batch_oligo_path(assigns(:batch_oligo))
  end

  test "should destroy batch_oligo" do
    assert_difference('BatchOligo.count', -1) do
      delete :destroy, :id => batch_oligos(:one).to_param
    end

    assert_redirected_to batch_oligos_path
  end
end
