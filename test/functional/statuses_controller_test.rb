require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should be redirected from new page when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when logged in" do
    sign_in users(:mark)
    get :new
    assert_response :success
  end

  test "should be redirected from posting status when not logged in" do
    post :create, status: { content: @status.content }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should post status when logged in" do
    sign_in users(:mark)

    assert_difference('Status.count') do
      post :create, status: { content: @status.content }
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should post status for the current user when logged in" do
    sign_in users(:mark)

    assert_difference('Status.count') do
      post :create, status: { content: @status.content, user_id: users(:bill).id }
    end

    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:mark).id
  end

  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  test "should be redirected from edit page when not logged in" do
    get :edit, id: @status
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the edit page when logged in" do
    sign_in users(:mark)
    get :edit, id: @status
    assert_response :success
  end

  test "should be redirected from updating status when not logged in" do
    put :update, id: @status, status: { content: @status.content }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should update status when logged in" do
    sign_in users(:mark)
    put :update, id: @status, status: { content: @status.content }
    assert_redirected_to status_path(assigns(:status))
  end

  test "should update status for the current user when logged in" do
    sign_in users(:mark)
    put :update, id: @status, status: { content: @status.content, user_id: users(:bill).id }
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:mark).id
  end

  test "should not update the status if nothing has changed" do
    sign_in users(:mark)
    put :update, id: @status
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:mark).id
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
