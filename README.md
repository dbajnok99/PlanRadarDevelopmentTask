# README

This application was created for the Development Task in the interview process at PlanRadar.

>PlanRadar is a SaaS application for construction documentation & defect management. Our customers create
lots of tickets every day. These tickets are usually created to report a defect and it is assigned to a project
member to fix it.

>Tickets usually contain fields like (Title, Description, Assignee, Due Date, Status, Progress ...etc.).

>We want to implement a new feature to send due date reminders emails to the users based on their profile
configuration.

## Setting up the project

```sh
rails db:create db:migrate
```

## Running the application

```sh
rails s
```

When the application is first started the database is empty, therefore first you have to add a user, and than add tickets.
In order to add these I suggest using Postman or other APIs.
To add a user, send a POST request to localhost:3000/users with parameters:
 - name (string)
 - mail (string)
 - send_due_date_reminder (boolean) (Activate / Deactivate due date reminders)
 - due_date_reminder_interval (number) (When to send the reminder? 0 = on due date, 1 = one day before the due date, ... etc.)
 - due_date_reminder_time (time) (At which time should we send the reminder)
 - time_zone (string) (The user's time zone i.e., Europe/Vienna)

 To add a ticket, send a POST request to localhost:3000/tickets with parameters:
 - title (string)
 - description (string)
 - assigned_user_id (integer)
 - due_date (date)]
 - status_id (integer)
 - progress (integer)

When creating a ticket an ActionMailer::MailDeliveryJob is created to be performed at the desired time.

## Running the test

```sh
rspec
```


