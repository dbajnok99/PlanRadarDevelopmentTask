require 'rails_helper'

RSpec.describe ReminderMailer, type: :mailer do
  let(:user) do
    create(:user, id: 1,
                  name: 'name',
                  mail: 'test@example.com',
                  send_due_date_reminder: true,
                  due_date_reminder_interval: 1,
                  due_date_reminder_time: '11:30',
                  time_zone: 'Europe/Vienna')
  end

  let(:ticket) do
    create(:ticket, id: 1,
                    title: 'title',
                    description: 'description',
                    assigned_user_id: 1,
                    due_date: '2022-06-07',
                    status_id: 1,
                    progress: 1)
  end

  before do
    user
    ticket
  end

  describe 'Email delivery' do
    let(:mail) { ReminderMailer.ticket_reminder(1) }
    it 'renders the headers' do
      expect(mail.subject).to eq 'Reminder!'
      expect(mail.to).to eq ['test@example.com']
      expect(mail.from).to eq ['reminder@hosting2153613.online.pro']
    end
    it 'renders the body' do
      expect(mail.body.encoded).to have_content 'name' # user.name
      expect(mail.body.encoded).to have_content 'title' # ticket.title
      expect(mail.body.encoded).to have_content 'description' # ticket.descripton
      expect(mail.body.encoded).to have_content '2022-06-07' # ticket.due_date
    end
  end
end
