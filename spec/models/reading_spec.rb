require 'rails_helper'

RSpec.describe Reading, type: :model do

  describe 'associations' do
    it { should belong_to(:thermostat) }
  end

  describe 'validation' do
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:temperature) }
    it { should validate_presence_of(:humidity) }
    it { should validate_presence_of(:battery_charge) }
  end
end