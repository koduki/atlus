require 'test_helper'

class SnipetsControllerTest < ActionController::TestCase
  setup do
    @snipet = snipets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:snipets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create snipet" do
    assert_difference('Snipet.count') do
      post :create, snipet: { chartType: @snipet.chartType, isChartVisible: @snipet.isChartVisible, isTableVisible: @snipet.isTableVisible, name: @snipet.name, query: @snipet.query }
    end

    assert_redirected_to snipet_path(assigns(:snipet))
  end

  test "should show snipet" do
    get :show, id: @snipet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @snipet
    assert_response :success
  end

  test "should update snipet" do
    put :update, id: @snipet, snipet: { chartType: @snipet.chartType, isChartVisible: @snipet.isChartVisible, isTableVisible: @snipet.isTableVisible, name: @snipet.name, query: @snipet.query }
    assert_redirected_to snipet_path(assigns(:snipet))
  end

  test "should destroy snipet" do
    assert_difference('Snipet.count', -1) do
      delete :destroy, id: @snipet
    end

    assert_redirected_to snipets_path
  end
end
