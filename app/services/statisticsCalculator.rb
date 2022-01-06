class StatisticsCalculator < ApplicationService
  def initialize(thermostat_id)
    @thermostat = Thermostat.find(thermostat_id)
  end

  def call
    stats
  end

  private

  # return array of hash with avg, min and max by temerature, humidity and battery_charge for a particular thermostat
  def stats
    main_db_results = main_database_stats
    redis_results = redis_database_stats

    reading_statistics = []
    if redis_results.empty?
      reading_statistics = main_db_results
    elsif main_db_results.empty?
      reading_statistics = redis_results
    else
      main_db_results.each_with_index do |value,index|
        value.each do |k,value|
          avg_val = (value["avg"].to_f + redis_results[index][k]["avg"].to_f) / 2
          min_val = [value["min"].to_f, redis_results[index][k]["min"].to_f].min
          max_val = [value["max"].to_f, redis_results[index][k]["max"].to_f].max

          reading_statistics << {k => {avg: avg_val, min: min_val, max: max_val} }
        end
      end
    end

    reading_statistics 
  end

  # get avg, min, max readings for temperature/humidity/battery_charge for a household from the main DB
  def main_database_stats
    house_stats = []

    calculations = @thermostat.readings.pluck('Avg(temperature)', 'Min(temperature)', 'Max(temperature)', 
                                              'Avg(humidity)','Min(humidity)', 'Max(humidity)', 
                                              'Avg(battery_charge)', 'Min(battery_charge)', 'Max(battery_charge)').first
     
    unless calculations.empty?
      house_stats << { temperature: {"avg" => calculations[0].round(2), "min" => calculations[1], "max" => calculations[2]}}
      house_stats << { humidity: {"avg" => calculations[3].round(2), "min" => calculations[4], "max" => calculations[5]}}
      house_stats << { battery_charge: {"avg" => calculations[6].round(2), "min" => calculations[7], "max" => calculations[8]}}
    end
    
    house_stats
  end
  
  def redis_database_stats
    redis_data = []
    redis_calculations = []

    reading_keys = $redis_db.scan(0, match: 'reading_*')[1]

    unless reading_keys.empty?
      reading_keys.each do |key|
        reading = eval(get_redis_value(key))

        next if !reading["thermostat_id"].eql?(@thermostat.id)

        redis_data << { temperature: reading["temperature"], humidity: reading["humidity"],  battery_charge: reading["battery_charge"] }
      end
    end

    unless redis_data.blank?
      data_keys = ["temperature", "humidity", "battery_charge"]
      averages = averages_data(data_keys, redis_data)
      minimums = minimum_data(data_keys, redis_data)
      maximums = maximum_data(data_keys, redis_data)
      
      redis_calculations << { temperature: {"avg" => averages[0].round(2), "min" => minimums[0], "max" => maximums[0]}}
      redis_calculations << { humidity: {"avg" => averages[1].round(2), "min" => minimums[1], "max" => maximums[1]}}
      redis_calculations << { battery_charge: {"avg" => averages[2].round(2), "min" => minimums[2], "max" => maximums[2]}}
    end

    return redis_calculations
  end

  # get redis value by key
  def get_redis_value(key)
    $redis_db.get(key)
  end

  # calculate the avaerages of temerature, humidity and battery_charge 
  def averages_data(data_keys, redis_data)
    data_keys.map do |key|
      redis_data.map { |h| h[key.to_sym].to_f }.sum / redis_data.size
    end
  end

  # get minimum reading for temperature, humidity and battery_charge
  def minimum_data(data_keys, redis_data)
    data_keys.map do |type|
      redis_data.min_by { |h| h[type.to_sym] }[type.to_sym]
    end
  end

  # get's max by temperature, humidity and battery_charge
  def maximum_data(attributes, redis_data)
    attributes.map do |type|
      redis_data.max_by { |h| h[type.to_sym] }[type.to_sym]
    end
  end    
end