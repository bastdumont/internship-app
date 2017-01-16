json.extract! contact, :id, :name, :company_id, :email, :phone, :main_contact, :created_at, :updated_at
json.url contact_url(contact, format: :json)