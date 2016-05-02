require 'test_helper'

class FeaturedTrailorsControllerTest < ActionController::TestCase
  setup do
    @featured_trailor = featured_trailors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:featured_trailors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create featured_trailor" do
    assert_difference('FeaturedTrailor.count') do
      post :create, featured_trailor: { movie_id: @featured_trailor.movie_id, position: @featured_trailor.position }
    end

    assert_redirected_to featured_trailor_path(assigns(:featured_trailor))
  end

  test "should show featured_trailor" do
    get :show, id: @featured_trailor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @featured_trailor
    assert_response :success
  end

  test "should update featured_trailor" do
    patch :update, id: @featured_trailor, featured_trailor: { movie_id: @featured_trailor.movie_id, position: @featured_trailor.position }
    assert_redirected_to featured_trailor_path(assigns(:featured_trailor))
  end

  test "should destroy featured_trailor" do
    assert_difference('FeaturedTrailor.count', -1) do
      delete :destroy, id: @featured_trailor
    end

    assert_redirected_to featured_trailors_path
  end
end
