require 'test_helper'

class BatchImagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:batch_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create batch_image" do
    assert_difference('BatchImage.count') do
      post :create, :batch_image => { }
    end

    assert_redirected_to batch_image_path(assigns(:batch_image))
  end

  test "should show batch_image" do
    get :show, :id => batch_images(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => batch_images(:one).to_param
    assert_response :success
  end

  test "should update batch_image" do
    put :update, :id => batch_images(:one).to_param, :batch_image => { }
    assert_redirected_to batch_image_path(assigns(:batch_image))
  end

  test "should destroy batch_image" do
    assert_difference('BatchImage.count', -1) do
      delete :destroy, :id => batch_images(:one).to_param
    end

    assert_redirected_to batch_images_path
  end
end
