require 'test_helper'

class MicroArrayImagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:micro_array_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create micro_array_image" do
    assert_difference('MicroArrayImage.count') do
      post :create, :micro_array_image => { }
    end

    assert_redirected_to micro_array_image_path(assigns(:micro_array_image))
  end

  test "should show micro_array_image" do
    get :show, :id => micro_array_images(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => micro_array_images(:one).to_param
    assert_response :success
  end

  test "should update micro_array_image" do
    put :update, :id => micro_array_images(:one).to_param, :micro_array_image => { }
    assert_redirected_to micro_array_image_path(assigns(:micro_array_image))
  end

  test "should destroy micro_array_image" do
    assert_difference('MicroArrayImage.count', -1) do
      delete :destroy, :id => micro_array_images(:one).to_param
    end

    assert_redirected_to micro_array_images_path
  end
end
