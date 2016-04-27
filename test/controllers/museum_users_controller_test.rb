require 'test_helper'

class MuseumUsersControllerTest < ActionController::TestCase
  setup do
    @museum_user = museum_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:museum_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create museum_user" do
    assert_difference('MuseumUser.count') do
      post :create, museum_user: {  }
    end

    assert_redirected_to museum_user_path(assigns(:museum_user))
  end

  test "should show museum_user" do
    get :show, id: @museum_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @museum_user
    assert_response :success
  end

  test "should update museum_user" do
    patch :update, id: @museum_user, museum_user: {  }
    assert_redirected_to museum_user_path(assigns(:museum_user))
  end

  test "should destroy museum_user" do
    assert_difference('MuseumUser.count', -1) do
      delete :destroy, id: @museum_user
    end

    assert_redirected_to museum_users_path
  end
end
