json.extract! company, :id, :name, :area_of_interest, :description, :status, :website, :city, :notes, :adress, :created_at, :updated_at
json.url company_url(company, format: :json)