require 'rails_helper'

describe 'tickets' do
  let(:send_due_date_reminder) { true }
  let(:user) do
    create(:user, id: 1,
                  name: 'name',
                  mail: 'test@example.com',
                  send_due_date_reminder: send_due_date_reminder,
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

  context 'when testing reminder_date' do
    it 'returns the desired date for the reminder with the given time and the given interval before the due date' do
      expect(Ticket.find(1).reminder_date).to eq(Time.find_zone('Europe/Vienna').local(2022, 6, 6, 11, 30))
    end
  end

  context 'when testing set_email_reminder' do
    context 'with user having false for send_due_date_reminder' do
      let(:send_due_date_reminder) { false }

      it 'returns without doing anything' do
        expect(Ticket.find(1).set_email_reminder).to be(nil)
      end
    end

    context 'with user having true for send_due_date_reminder' do
      let(:send_due_date_reminder) { true }

      it 'returns without doing anything' do
        expect(Ticket.find(1).set_email_reminder).to eq('succes')
      end
    end
  end
end
