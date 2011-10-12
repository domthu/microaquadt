require 'test_helper'

class OligoSequencesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oligo_sequences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oligo_sequence" do
    assert_difference('OligoSequence.count') do
      post :create, :oligo_sequence => { }
    end

    assert_redirected_to oligo_sequence_path(assigns(:oligo_sequence))
  end

  test "should show oligo_sequence" do
    get :show, :id => oligo_sequences(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => oligo_sequences(:one).to_param
    assert_response :success
  end

  test "should update oligo_sequence" do
    put :update, :id => oligo_sequences(:one).to_param, :oligo_sequence => { }
    assert_redirected_to oligo_sequence_path(assigns(:oligo_sequence))
  end

  test "should destroy oligo_sequence" do
    assert_difference('OligoSequence.count', -1) do
      delete :destroy, :id => oligo_sequences(:one).to_param
    end

    assert_redirected_to oligo_sequences_path
  end
end
