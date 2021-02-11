require 'test_helper'

class ControllersAndActionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:controllers_and_actions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_controllers_and_action
    assert_difference('ControllersAndAction.count') do
      post :create, :controllers_and_action => { }
    end

    assert_redirected_to controllers_and_action_path(assigns(:controllers_and_action))
  end

  def test_should_show_controllers_and_action
    get :show, :id => controllers_and_actions(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => controllers_and_actions(:one).id
    assert_response :success
  end

  def test_should_update_controllers_and_action
    put :update, :id => controllers_and_actions(:one).id, :controllers_and_action => { }
    assert_redirected_to controllers_and_action_path(assigns(:controllers_and_action))
  end

  def test_should_destroy_controllers_and_action
    assert_difference('ControllersAndAction.count', -1) do
      delete :destroy, :id => controllers_and_actions(:one).id
    end

    assert_redirected_to controllers_and_actions_path
  end
end
