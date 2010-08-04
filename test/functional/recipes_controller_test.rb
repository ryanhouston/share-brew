require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post :create, :recipe => { }
    end

    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should show recipe" do
    get :show, :id => recipes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => recipes(:one).to_param
    assert_response :success
  end

  test "should update recipe" do
    put :update, :id => recipes(:one).to_param, :recipe => { }
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, :id => recipes(:one).to_param
    end

    assert_redirected_to recipes_path
  end
end
