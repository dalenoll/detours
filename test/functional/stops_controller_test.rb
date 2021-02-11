require 'test_helper'

class StopsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:stops)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_stops
    assert_difference('Stops.count') do
      post :create, :stops => { }
    end

    assert_redirected_to stops_path(assigns(:stops))
  end

  def test_should_show_stops
    get :show, :id => stops(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => stops(:one).id
    assert_response :success
  end

  def test_should_update_stops
    put :update, :id => stops(:one).id, :stops => { }
    assert_redirected_to stops_path(assigns(:stops))
  end

  def test_should_destroy_stops
    assert_difference('Stops.count', -1) do
      delete :destroy, :id => stops(:one).id
    end

    assert_redirected_to stops_path
  end
end
