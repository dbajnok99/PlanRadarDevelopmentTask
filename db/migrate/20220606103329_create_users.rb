class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mail
      t.boolean :send_due_date_reminder
      t.integer :due_date_reminder_interval
      t.time :due_date_reminder_time
      t.string :time_zone
    end
  end
end
