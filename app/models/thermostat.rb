class Thermostat < ApplicationRecord
    # one-to-many association with thermostats
    has_many :readings

    #validations
    validates :household_token, presence: true, uniqueness: true
    validates :location, presence: true

    
end
