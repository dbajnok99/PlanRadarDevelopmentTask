require "test_helper"

class TicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket = tickets(:one)
  end

  test "should get index" do
    get tickets_url, as: :json
    assert_response :success
  end

  test "should create ticket" do
    assert_difference("Ticket.count") do
      post tickets_url, params: { ticket: { assigned_user_id: @ticket.assigned_user_id, created_at: @ticket.created_at, description: @ticket.description, due_date: @ticket.due_date, progress: @ticket.progress, status_id: @ticket.status_id, title: @ticket.title, updated_at: @ticket.updated_at } }, as: :json
    end

    assert_response :created
  end

  test "should show ticket" do
    get ticket_url(@ticket), as: :json
    assert_response :success
  end

  test "should update ticket" do
    patch ticket_url(@ticket), params: { ticket: { assigned_user_id: @ticket.assigned_user_id, created_at: @ticket.created_at, description: @ticket.description, due_date: @ticket.due_date, progress: @ticket.progress, status_id: @ticket.status_id, title: @ticket.title, updated_at: @ticket.updated_at } }, as: :json
    assert_response :success
  end

  test "should destroy ticket" do
    assert_difference("Ticket.count", -1) do
      delete ticket_url(@ticket), as: :json
    end

    assert_response :no_content
  end
end
