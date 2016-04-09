require 'test_helper'

class PanoramasControllerTest < ActionController::TestCase
  setup do
    @panorama = panoramas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:panoramas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create panorama" do
    assert_difference('Panorama.count') do
      post :create, panorama: { show: @panorama.show }
    end

    assert_redirected_to panorama_path(assigns(:panorama))
  end

  test "should show panorama" do
    get :show, id: @panorama
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @panorama
    assert_response :success
  end

  test "should update panorama" do
    patch :update, id: @panorama, panorama: { show: @panorama.show }
    assert_redirected_to panorama_path(assigns(:panorama))
  end

  test "should destroy panorama" do
    assert_difference('Panorama.count', -1) do
      delete :destroy, id: @panorama
    end

    assert_redirected_to panoramas_path
  end
end
