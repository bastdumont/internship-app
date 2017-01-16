class User < ActiveRecord::Base
         has_many :positions
         has_many :contacts
         has_secure_password
         
         def self.options_for_select
         order('LOWER(name)').map { |e| [e.name, e.id] }
         end
end
