class TicketsController < ApplicationController
  before_action :set_ticket_and_user, only: %i[show update destroy]

  # GET /tickets
  def index
    @tickets = Ticket.all

    render json: @tickets
  end

  # GET /tickets/1
  def show
    render json: @ticket
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)
    @user = User.find(@ticket.assigned_user_id)

    if @ticket.save
      set_email_reminder
      render json: @ticket, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tickets/1
  def update
    if @ticket.update(ticket_params)
      set_email_reminder
      render json: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket_and_user
    @ticket = Ticket.find(params[:id])
    @user = User.find(@ticket.assigned_user_id)
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.permit(:id, :title, :description, :assigned_user_id, :due_date, :status_id, :progress, :created_at,
                  :updated_at)
  end

  def reminder_date
    date = @ticket.due_date.days_ago(@user.due_date_reminder_interval)
    time = @user.due_date_reminder_time
    new_time = time.change({ year: date.year, month: date.month, day: date.day })
    new_time.asctime.in_time_zone(@user.time_zone)
  end

  def set_email_reminder
    return unless @user.send_due_date_reminder

    ReminderMailer.ticket_reminder(@ticket.id).deliver_later!(wait_until: reminder_date)
  end
end
