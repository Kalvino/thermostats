class ThermostatsController < ApplicationController
  before_action :get_thermostat, except: %i[index]

  def index
    @thermostats = Thermostat.all 
  end

  def create
    @thermostat = Thermostat.create!(thermostat_params)
    json_response(@thermostat)
  end

  def show
    @stats = StatisticsCalculator.call(@thermostat.id)
    # @stats = json_response(stats)
    @readings = @thermostat.readings
  end

  private

  def get_thermostat
    @thermostat = Thermostat.find(params[:id])
  end

  def thermostat_params
    params.require(:thermostat).permit(:household_token, :location)
  end
end
