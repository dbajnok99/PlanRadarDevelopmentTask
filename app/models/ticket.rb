class Ticket < ApplicationRecord
  belongs_to :user, inverse_of: :tickets, foreign_key: 'assigned_user_id'

  def reminder_date
    date = due_date.days_ago(user.due_date_reminder_interval)
    time = user.due_date_reminder_time
    new_time = time.change({ year: date.year, month: date.month, day: date.day })
    new_time.asctime.in_time_zone(user.time_zone)
  end

  def set_email_reminder
    return unless user.send_due_date_reminder

    ReminderMailer.ticket_reminder(id).deliver_later!(wait_until: reminder_date)
  end
end
