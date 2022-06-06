class ReminderMailer < ApplicationMailer
  def ticket_reminder(ticket_id)
    @ticket = Ticket.find(ticket_id)
    @user = User.find(@ticket.assigned_user_id)
    mail to: @user.mail, from: 'reminder@hosting2153613.online.pro', subject: 'Reminder!'
  end
end
