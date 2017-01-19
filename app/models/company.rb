class Company < ActiveRecord::Base
     has_many :contacts
     has_many :clients
    
     filterrific(
      available_filters: [
    :with_area_of_interest,
    :with_status,
    :search_query,
    :sorted_by,
  ]
)
    
  scope :with_area_of_interest, lambda { |area_of_interests|
  where(area_of_interest: [*area_of_interests])
}

 scope :with_status, lambda { |statuss|
  where(status: [*statuss])
}

 scope :search_query, lambda { |query|
  # Searches the students table on the 'first_name' and 'last_name' columns.
  # Matches using LIKE, automatically appends '%' to each term.
  # LIKE is case INsensitive with MySQL, however it is case
  # sensitive with PostGreSQL. To make it work in both worlds,
  # we downcase everything.
  return nil  if query.blank?

  # condition query, parse into individual keywords
  terms = query.downcase.split(/\s+/)

  # replace "*" with "%" for wildcard searches,
  # append '%', remove duplicate '%'s
  terms = terms.map { |e|
    (e.gsub('*', '%') + '%').gsub(/%+/, '%')
  }
  # configure number of OR conditions for provision
  # of interpolation arguments. Adjust this if you
  # change the number of OR conditions.
  num_or_conds = 1
  where(
    terms.map { |term|
      "(LOWER(companies.name) LIKE ?)"
    }.join(' AND '),
    *terms.map { |e| [e] * num_or_conds }.flatten
  )
}
      
    def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
    end
    
    def self.options_for_filtered_area
    [
      ['Marketing', 'Marketing'],
      ['Finance', 'Finance'],
      ['Arhcitecture', 'Architecture'],
      ['Consulting', 'Consulting'],
      ['Engineering', 'Engineering'], 
      ['Event Management & PR', 'Event Management & PR'],
      ['Fashion', 'Fashion'], 
      ['General Business', 'General Business'],
      ['Graphic Design', 'Graphic Design'],
      ['Hospitality', 'Hospitality'],
      ['Human Ressoures','Human Ressoures'],
      ['International Business', 'International Business'],
      ['IT & Web', 'IT & Web'], 
      ['Law', 'Law'],
      ['NGO', 'NGO'],
      ['Public Relations', 'Public Relations'],
      ['Sales', 'Sales'],
      ['Interior Design', 'Interior Design'],
      ['Real Estate', 'Real Estate'],
      ['Sport', 'Sport'],
      ['Health', 'Health'],
      ['Education & Training', 'Education & Training'],
      ['Journalism & Media', 'Journalism & Media'],
      ['Film & Video', 'Film & Video'],
      ['Import Export / Logistics', 'Import Export / Logistics'],
      ['Translation', 'Translation'],
      ['Project Management', 'Project Management'],
      ['Art & Culture', 'Art & Culture'],
      ['Green Tech / Renewable Energies', 'Green Tech / Renewable Energies']
    ]
    end
    
    def self.options_for_status
    [
      ['Partner', 'Partner'],
      ['Lead', 'Lead'],
      ['Closed', 'Closed'],
    ]
    end
    def self.options_for_cities
    [
      ['Shanghai', 'Shanghai'],
      ['Beijing', 'Beijing'],
      ['Shenzhen', 'Shenzhen'],
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

      company_hash = row.to_hash # exclude the price field
      company = Company.where(id: company_hash["id"])

      if company.count == 1
        company.first.update_attributes(company_hash)
      else
        Company.create!(company_hash)
      end # end if !product.nil?
    end # end CSV.foreach
  end # end self.import(file)
  
end
