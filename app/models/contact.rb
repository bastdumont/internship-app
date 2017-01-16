class Contact < ActiveRecord::Base
     belongs_to :company
     has_many :positions
     belongs_to :user
     
      filterrific(
      available_filters: [
    :with_company_id,
    :sorted_by,
  ]
)


scope :with_company_id, lambda { |company_ids|
  where(company_id: [*company_ids])
}

scope :sorted_by, lambda { |sort_option|
  # extract the sort direction from the param value.
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
  when /^registered_at_/
    # Simple sort on the created_at column.
    # Make sure to include the table name to avoid ambiguous column names.
    # Joining on other tables is quite common in Filterrific, and almost
    # every ActiveRecord table has a 'created_at' column.
    order("contacts.created_at #{ direction }")
  when /^name_/
    # Simple sort on the name colums
    order("LOWER(contacts.name) #{ direction }")
   when /^company_id_/
    # Simple sort on the name colums
    order("LOWER(contacts.company_id) #{ direction }")    
  else
    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
}

def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
end

end
