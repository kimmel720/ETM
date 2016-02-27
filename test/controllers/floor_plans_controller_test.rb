require 'test_helper'

class FloorPlansControllerTest < ActionController::TestCase
  setup do
    @floor_plan = floor_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:floor_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create floor_plan" do
    assert_difference('FloorPlan.count') do
      post :create, floor_plan: { name: @floor_plan.name }
    end

    assert_redirected_to floor_plan_path(assigns(:floor_plan))
  end

  test "should show floor_plan" do
    get :show, id: @floor_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @floor_plan
    assert_response :success
  end

  test "should update floor_plan" do
    patch :update, id: @floor_plan, floor_plan: { name: @floor_plan.name }
    assert_redirected_to floor_plan_path(assigns(:floor_plan))
  end

  test "should destroy floor_plan" do
    assert_difference('FloorPlan.count', -1) do
      delete :destroy, id: @floor_plan
    end

    assert_redirected_to floor_plans_path
  end
end
