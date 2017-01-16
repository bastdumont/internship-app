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
      ['Event Management', 'Event Management'],
      ['Fashion', 'Fashion'], 
      ['General Business', 'General Business'],
      ['Graphic Design', 'Graphic Design'],
      ['Hospitality', 'Hospitality'],
      ['Human Ressoures','Human Ressoures'],
      ['International Business', 'International Business'],
      ['IT & Web', 'IT & Web'], ['Journalism','Journalism'],
      ['Law', 'Law'],
      ['NGO', 'NGO'],
      ['Public Relations', 'Public Relations'],
      ['Sales', 'Sales']
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
end
