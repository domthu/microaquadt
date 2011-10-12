require 'test_helper'

class MicroArrayAnalysisFilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:micro_array_analysis_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create micro_array_analysis_file" do
    assert_difference('MicroArrayAnalysisFile.count') do
      post :create, :micro_array_analysis_file => { }
    end

    assert_redirected_to micro_array_analysis_file_path(assigns(:micro_array_analysis_file))
  end

  test "should show micro_array_analysis_file" do
    get :show, :id => micro_array_analysis_files(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => micro_array_analysis_files(:one).to_param
    assert_response :success
  end

  test "should update micro_array_analysis_file" do
    put :update, :id => micro_array_analysis_files(:one).to_param, :micro_array_analysis_file => { }
    assert_redirected_to micro_array_analysis_file_path(assigns(:micro_array_analysis_file))
  end

  test "should destroy micro_array_analysis_file" do
    assert_difference('MicroArrayAnalysisFile.count', -1) do
      delete :destroy, :id => micro_array_analysis_files(:one).to_param
    end

    assert_redirected_to micro_array_analysis_files_path
  end
end
