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

      position_hash = row.to_hash # exclude the price field
      position = Position.where(id: position_hash["id"])

      if position.count == 1
        position.first.update_attributes(position_hash)
      else
        Position.create!(position_hash)
      end # end if !product.nil?
    end # end CSV.foreach
  end # end self.import(file)
  
end
