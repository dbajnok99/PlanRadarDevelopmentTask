FactoryBot.define do
  factory :ticket do
    id { 1 }
    title { 'title' }
    description { 'description' }
    assigned_user_id { 1 }
    due_date { '2022-06-07' }
    status_id { 1 }
    progress { 1 }
  end
end
