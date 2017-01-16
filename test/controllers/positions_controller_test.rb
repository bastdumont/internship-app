require 'test_helper'

class PositionsControllerTest < ActionController::TestCase
  setup do
    @position = positions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:positions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create position" do
    assert_difference('Position.count') do
      post :create, position: { allowance: @position.allowance, area_of_interest: @position.area_of_interest, capacity: @position.capacity, city: @position.city, company_id: @position.company_id, contact_id: @position.contact_id, description: @position.description, hiring_opportunity: @position.hiring_opportunity, link: @position.link, name: @position.name, remarks: @position.remarks, requirements: @position.requirements, status: @position.status, user_id: @position.user_id }
    end

    assert_redirected_to position_path(assigns(:position))
  end

  test "should show position" do
    get :show, id: @position
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @position
    assert_response :success
  end

  test "should update position" do
    patch :update, id: @position, position: { allowance: @position.allowance, area_of_interest: @position.area_of_interest, capacity: @position.capacity, city: @position.city, company_id: @position.company_id, contact_id: @position.contact_id, description: @position.description, hiring_opportunity: @position.hiring_opportunity, link: @position.link, name: @position.name, remarks: @position.remarks, requirements: @position.requirements, status: @position.status, user_id: @position.user_id }
    assert_redirected_to position_path(assigns(:position))
  end

  test "should destroy position" do
    assert_difference('Position.count', -1) do
      delete :destroy, id: @position
    end

    assert_redirected_to positions_path
  end
end
