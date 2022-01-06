class ReadingsController < ApplicationController
  before_action :get_thermostat, only: %i[index new create]
  before_action :get_reading, except: :index
  skip_before_action :verify_authenticity_token

  # return all thermostat readings
  def index
    @thermostats = Thermostat.all
    render json: @thermostats
  end

  # add reading for a thermostat
  def create
    number = Reading.sequence_number
    new_hash = request.parameters.merge(number: number)
    params_extract = new_hash.extract!(:temperature, :humidity, :battery_charge, :thermostat_id, :number)

    ReadingCreator.call(params_extract)
    json_response(params_extract)
  end

  # return reading data for a particular reading with a sequence number
  def show
    @reading = $redis_db.get("reading_" + params[:id].to_s) || Reading.find(params[:id])
    json_response({ message: "Record not found" }) and return if !@reading
  end

  # all reading data for a particular household
  def house_readings
    @readings = @thermostat.readings
    json_response(@readings)
  end

  private

  def get_thermostat
    @thermostat = Thermostat.find(params[:thermostat_id])
  end
  # identify thermostat based on household token
  def get_reading
    reading_id = params[:id] 
    render json: { message: 'Missing Reading ID!' }, status: 401 and return if !reading_id
    @reading = Reading.find(reading_id)
    json_response({ message: 'Invalid Reading ID!' }, status: 401) and return if !@reading
  end

  # reading params
  def reading_params
    params.require(:reading).permit(:temperature, :humidity, :battery_charge, :thermostat_id, :number)
  end    
end