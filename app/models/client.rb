class Client < ActiveRecord::Base
      belongs_to :position
      belongs_to :company
      
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
    order("clients.created_at #{ direction }")
  when /^name_/
    # Simple sort on the name colums
    order("LOWER(clients.name) #{ direction }")
  when /^position_id_/
    # Simple sort on the name colums
    order("LOWER(clients.position_id) #{ direction }")
   when /^company_id_/
    # Simple sort on the name colums
    order("LOWER(clients.company_id) #{ direction }")    
  else
    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
}

 scope :with_created_at, lambda { |ref_date|
  }

  # This method provides select options for the `sorted_by` filter select input.
  # It is called in the controller as part of `initialize_filterrific`.
  def self.options_for_sorted_by
    [
      ['Company ', 'company_name_asc'],
      ['Internship', 'position_name_asc'],

    ]
  end

def self.as_csv
  CSV.generate do |csv|
    csv << column_names
    all.each do |item|
      csv << item.attributes.values_at(*column_names)
    end
  end
end

 def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      client_hash = row.to_hash # exclude the price field
      client = Client.where(id: client_hash["id"])

      if client.count == 1
        client.first.update_attributes(client_hash)
      else
        Client.create!(client_hash)
      end # end if !product.nil?
    end # end CSV.foreach
  end # end self.import(file)

end
