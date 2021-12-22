# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## Calvin

rails new finlink -d postgresql
rails db:create

rails g model Thermostat household_token:string location:string 
rails g model Reading thermostat:references number:integer temperature:float humidity:float battery_charge:float 

rails db:migrate
rails db:test:prepare
rails db:seed

Add jbuilder
Add redis configredis
Add sidekiq - worker app/workers/reading_worker.rb 
Add rspec
add shoulda-matchers' gem for testing improvement for rspec
    

bundle install
rails generate rspec:install

add view pages

handle routes

rails g controller Readings create index show
rails g controller Thermostats 


#tests
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





things to check  - shoulda matchers gem spec/rails/helper