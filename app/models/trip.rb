class Trip < ApplicationRecord
  validates_presence_of :duration,
                        :start_date,
                        :start_station,
                        :end_date,
                        :end_station,
                        :bike_id,
                        :subscription_type,
                        :zip_code


  belongs_to :start_station, :class_name => 'Station'
  belongs_to :end_station, :class_name => 'Station'

  def self.average_duration
    average(:duration).round(2)
  end

  def self.longest_duration
    maximum(:duration).round(2)
  end

  def self.shortest_duration
    minimum(:duration).round(2)
  end

  def self.station_start_max
    select('start_station_id, count(start_station_id) as trips_from').group(:start_station_id).order('trips_from desc').limit(1).first.start_station.name
  end

  def self.station_end_max
    select('start_station_id, count(start_station_id) as trips_from').group(:start_station_id).order('trips_from').limit(1).first.start_station.name
  end

  def self.number_of_rides_per_month
    group("date_trunc('month', start_date)").order("date_trunc('month', start_date)").count
  end

  def self.total_trips_per_year
    group("date_trunc('year', start_date)").order('count_all desc').count
  end

  def self.bike_with_most_rides
    select('trips.bike_id, count(bike_id) as count').group(:bike_id).order('count desc').first.bike_id
  end

  def self.most_rides_on_one_bike
    select('trips.bike_id, count(bike_id) as count').group(:bike_id).order('count desc').first.count
  end

  def self.bike_with_least_rides
    select('trips.bike_id, count(bike_id) as count').group(:bike_id).order('count').first.bike_id
  end

  def self.least_rides_on_one_bike
    select('trips.bike_id, count(bike_id) as count').group(:bike_id).order('count').first.count
  end

  def self.subscriber_count
    where(subscription_type:'Subscriber').count
  end

  def self.customer_count
    where(subscription_type:'Customer').count
  end

  def self.subscriber_percent
    ((subscriber_count * 100.00)/all.count).round(2)
  end

  def self.customer_percent
    ((customer_count * 100.00)/all.count).round(2)
  end

  def self.date_with_most_trips
    group("date_trunc('day', start_date)").order('count_all desc').count.first[0]
  end

  def self.most_trips_in_one_day_count
    group("date_trunc('day', start_date)").order('count_all desc').count.first[1]
  end

  def self.most_trips_weather
    Condition.find_by_cond_date(date_with_most_trips)
  end

  def self.date_with_least_trips
    group("date_trunc('day', start_date)").order('count_all').count.first[0]
  end

  def self.least_trips_in_one_day_count
    group("date_trunc('day', start_date)").order('count_all').count.first[1]
  end

  def self.least_trips_weather
    Condition.find_by_cond_date(date_with_least_trips)
  end

  def self.highest_rides_per_temp(range)
    unless Condition.where(max_temperature: (range)).count == 0
      where(start_date: Condition.where(max_temperature: (range)).pluck("date_trunc('day', cond_date)")).select('trips.start_date, count(id) as count').group(:start_date).order('count desc').first.count
    else
      0
    end
  end

  def self.average_rides_per_temp(range)
    x = Trip.where(start_date: Condition.where(max_temperature: (range)).pluck("date_trunc('day', cond_date)")).group(:start_date).count.values
    unless x.count == 0
      (x.sum.to_f / x.count).round(2)
    else
      0
    end
    # where(start_date: Condition.where(max_temperature: (range)).pluck("date_trunc('day', cond_date)")).select('trips.start_date, count(id) as count').group(:start_date).order('count desc').average('count')
  end

  def self.lowest_rides_per_temp(range)
    unless Condition.where(max_temperature: (range)).count == 0
      where(start_date: Condition.where(max_temperature: (range)).pluck("date_trunc('day', cond_date)")).select('trips.start_date, count(id) as count').group(:start_date).order('count').first.count
    else
      0
    end
  end

  def self.highest_rides_per_precipitation(range)
    unless Condition.where(precipitation: (range)).count == 0
      where(start_date: Condition.where(precipitation: (range)).pluck("date_trunc('day', cond_date)")).select('trips.start_date, count(id) as count').group(:start_date).order('count desc').first.count
    else
      0
    end
  end

  def self.average_rides_per_precipitation(range)
    x = Trip.where(start_date: Condition.where(precipitation: (range)).pluck("date_trunc('day', cond_date)")).group(:start_date).count.values
    unless x.count == 0
      (x.sum.to_f / x.count).round(2)
    else
      0
    end
  end

  def self.lowest_rides_per_precipitation(range)
    unless Condition.where(precipitation: (range)).count == 0
      where(start_date: Condition.where(precipitation: (range)).pluck("date_trunc('day', cond_date)")).select('trips.start_date, count(id) as count').group(:start_date).order('count').first.count
    else
      0
    end
  end

  def self.highest_rides_per_wind_speed(range)
    unless Condition.where(mean_wind_speed: (range)).count == 0
      where(start_date: Condition.where(mean_wind_speed: (range)).pluck("date_trunc('day', cond_date)")).select('trips.start_date, count(id) as count').group(:start_date).order('count desc').first.count
    else
      0
    end
  end

  def self.average_rides_per_wind_speed(range)
    x = Trip.where(start_date: Condition.where(mean_wind_speed: (range)).pluck("date_trunc('day', cond_date)")).group(:start_date).count.values
    unless x.count == 0
      (x.sum.to_f / x.count).round(2)
    else
      0
    end
  end

  def self.lowest_rides_per_wind_speed(range)
    unless Condition.where(mean_wind_speed: (range)).count == 0
      where(start_date: Condition.where(mean_wind_speed: (range)).pluck("date_trunc('day', cond_date)")).select('trips.start_date, count(id) as count').group(:start_date).order('count').first.count
    else
      0
    end
  end

  def self.highest_rides_per_mean_visibility(range)
    unless Condition.where(mean_visibility: (range)).count == 0
      where(start_date: Condition.where(mean_visibility: (range)).pluck("date_trunc('day', cond_date)")).select('trips.start_date, count(id) as count').group(:start_date).order('count desc').first.count
    else
      0
    end
  end

  def self.average_rides_per_mean_visibility(range)
    x = Trip.where(start_date: Condition.where(mean_visibility: (range)).pluck("date_trunc('day', cond_date)")).group(:start_date).count.values
    unless x.count == 0
      (x.sum.to_f / x.count).round(2)
    else
      0
    end
  end

  def self.lowest_rides_per_mean_visibility(range)
    unless Condition.where(mean_visibility: (range)).count == 0
      where(start_date: Condition.where(mean_visibility: (range)).pluck("date_trunc('day', cond_date)")).select('trips.start_date, count(id) as count').group(:start_date).order('count').first.count
    else
      0
    end
  end

end
