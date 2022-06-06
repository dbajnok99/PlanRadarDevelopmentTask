FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'name' }
    mail { 'test@example.com' }
    send_due_date_reminder { true }
    due_date_reminder_interval { 1 }
    due_date_reminder_time { '11:30' }
    time_zone { 'Europe/Vienna' }
  end
end
