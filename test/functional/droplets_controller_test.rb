require 'test_helper'

class DropletsControllerTest < ActionController::TestCase
  setup do
    @droplet = droplets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:droplets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create droplet" do
    assert_difference('Droplet.count') do
      post :create, droplet: @droplet.attributes
    end

    assert_redirected_to droplet_path(assigns(:droplet))
  end

  test "should show droplet" do
    get :show, id: @droplet.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @droplet.to_param
    assert_response :success
  end

  test "should update droplet" do
    put :update, id: @droplet.to_param, droplet: @droplet.attributes
    assert_redirected_to droplet_path(assigns(:droplet))
  end

  test "should destroy droplet" do
    assert_difference('Droplet.count', -1) do
      delete :destroy, id: @droplet.to_param
    end

    assert_redirected_to droplets_path
  end
end
