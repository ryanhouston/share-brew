require 'test_helper'

class IngredientsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingredient" do
    assert_difference('Ingredient.count') do
      post :create, :ingredient => { }
    end

    assert_redirected_to ingredient_path(assigns(:ingredient))
  end

  test "should show ingredient" do
    get :show, :id => ingredients(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ingredients(:one).to_param
    assert_response :success
  end

  test "should update ingredient" do
    put :update, :id => ingredients(:one).to_param, :ingredient => { }
    assert_redirected_to ingredient_path(assigns(:ingredient))
  end

  test "should destroy ingredient" do
    assert_difference('Ingredient.count', -1) do
      delete :destroy, :id => ingredients(:one).to_param
    end

    assert_redirected_to ingredients_path
  end
end
