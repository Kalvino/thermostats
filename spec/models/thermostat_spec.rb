require 'rails_helper'

RSpec.describe Thermostat, type: :model do

  describe 'model validation' do
    it { should validate_uniqueness_of(:household_token) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:household_token) }
  end

  describe 'model associations' do
    it { should have_many(:readings) }
  end

  it "invalid with empty parameter" do
    expect(build(:thermostat, household_token:nil, location:nil)).to_not be_valid
  end

  it "invalid without a house token" do
    expect(build(:thermostat, location:nil)).to_not be_valid
   end
  it "invalid without a location" do
   expect(build(:thermostat, location:nil)).to_not be_valid
  end


  it "valid with all paramerters provided" do
    expect(build(:thermostat, household_token:"hdfhdfd", location:"Erfurt ")).to be_valid
   end
end