require File.dirname(__FILE__) + '/../test_helper'
require 'homes_controller'

# Re-raise errors caught by the controller.
class HomesController; def rescue_action(e) raise e end; end

class HomesControllerTest < Test::Unit::TestCase
  fixtures :homes

  def setup
    @controller = HomesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:homes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_home
    assert_difference('Home.count') do
      post :create, :home => { }
    end

    assert_redirected_to home_path(assigns(:home))
  end

  def test_should_show_home
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_home
    put :update, :id => 1, :home => { }
    assert_redirected_to home_path(assigns(:home))
  end

  def test_should_destroy_home
    assert_difference('Home.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to homes_path
  end
end
