# README 

## Authored by Calvin

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to know:

* Ruby version 2.7.1
* Rails 6
## Technologies
- RSpec (unit/Integration testing)
- Redis
- Postgres
- Sidekiq (Background)

## Other Illustrations
User of;
- Service objects
- concerns
- composition over inheritence

## For Learning
rails new thermostat -d postgresql
rails db:create

rails g model Thermostat household_token:string location:string 
rails g model Reading thermostat:references number:integer temperature:float humidity:float battery_charge:float 

rails db:migrate
rails db:test:prepare
rails db:seed

Add jbuilder
Add redis config redis
Add sidekiq - worker app/workers/reading_worker.rb 
Add rspec
add shoulda-matchers' gem for testing improvement for rspec
    

bundle install
rails generate rspec:install

add view pages

handle routes

rails g controller Readings create index show
rails g controller Thermostats 


# tests
rake spec, rspec, bundle exec rspec

rake db:reset #drops the database, then loads the schema with rake db:schema:load and then seeds the data with rake db:seed

Reading.create!(thermostat_id: 1, number: 200, temperature: -7.5, humidity: 14, battery_charge: 31)


[
    {
        "temperature": {
            "avg": 16.0,
            "min": 15.0,
            "max": 17.0
        }
    },
    {
        "humidity": {
            "avg": 41.0,
            "min": 11.0,
            "max": 71.0
        }
    },
    {
        "battery_charge": {
            "avg": 30.5,
            "min": 11.0,
            "max": 50.0
        }
    }
]

[
    {
        "temperature": 15,
        "humidity": 11,
        "battery_charge": 11
    },
    {
        "temperature": 17,
        "humidity": 71,
        "battery_charge": 50
    }
]

start sidekiq
bundle exec sidekiq


Singleton Class - an anonymouse class added between an object and its actual class. When methods are called, the ones defined on the singleton class get precedence over the methods in the actual class.
ruby singleton methods are methods uniq to a single object

things to check  - shoulda matchers gem spec/rails/helper

// TODO
routing/crud
Refactor test
exception handling
