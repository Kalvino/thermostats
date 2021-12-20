require 'rails_helper'

RSpec.describe ReadingsController, type: :controller do
  let!(:thermostat)  {create(:thermostat)}
  let(:reading)  {create(:reading)}

  describe 'POST /readings' do
    context 'when household token not present' do
      it "returns token missing message" do
        post :create, params: { temperature: "15", humidity: "31", battery_charge: "89" }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["message"]).to eq('Missing household token!')
      end
    end

    context 'when household token is invalid' do
      it "return invalid household token message" do
        post :create, params: { household_token: 'abc', temperature: "15", humidity: "31", battery_charge: "89" }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["message"]).to eq('Invalid Household token!')
      end
    end

    context 'when params are missing and household token is valid' do
      it "return errors message" do
        post :create, params: { household_token: thermostat.household_token, humidity: "32" }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["message"]).to eq('Required parameters missing!')
      end
    end

    context 'when all required params are present and household token is valid' do
      it "return successful posting of readings" do
        post :create, params: { household_token: thermostat.household_token, number: 2, temperature: "15", humidity: "31", battery_charge: "89"}
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET /readings/:id' do
    context 'when household token not present' do
      it "returns token missing message" do
        get :show, params: { number: reading.number }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["message"]).to eq('Missing household token!')
      end
    end

    context 'when household token present' do
      it "renders a reading for a particular thermostat" do
        get :show, params: { household_token: thermostat.household_token, number: reading.number }
        expect(response.status).to eq(200)
      end
    end
  end
end