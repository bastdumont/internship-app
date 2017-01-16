class Position < ActiveRecord::Base
     belongs_to :user
     belongs_to :company
     has_many :clients
     belongs_to :contact
     
      filterrific(
      available_filters: [
    :with_area_of_interest,
    :with_status,
    :with_city,
    :with_user_id,
    :with_company_id
  ]
)

  scope :with_area_of_interest, lambda { |area_of_interests|
  where(area_of_interest: [*area_of_interests])
}

 scope :with_status, lambda { |statuss|
  where(status: [*statuss])
}

scope :with_city, lambda { |citys|
  where(city: [*citys])
}

scope :with_user_id, lambda { |user_ids|
  where(user_id: [*user_ids])
}

scope :with_company_id, lambda { |company_ids|
  where(company_id: [*company_ids])
}

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
      ['Open', 'Open'],
      ['Occupied', 'Occupied'],
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
