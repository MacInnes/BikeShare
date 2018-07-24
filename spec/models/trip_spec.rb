require 'rails_helper'

describe Trip do
  context 'validations' do
    it {should validate_presence_of(:duration)}
    it {should validate_presence_of(:start_date)}
    it {should validate_presence_of(:start_station)}
    it {should validate_presence_of(:end_date)}
    it {should validate_presence_of(:end_station)}
    it {should validate_presence_of(:bike_id)}
    it {should validate_presence_of(:subscription_type)}
    it {should validate_presence_of(:zip_code)}
  end
  context 'class methods' do
    xit 'calculates th average duration of a ride' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station: 2, end_date: '8/10/2010', end_station: 2, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)

      expect(Trip.average_duration).to eq(9)
    end
    xit 'calculates the longest ride' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station: 2, end_date: '8/10/2010', end_station: 2, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)

      expect(Trip.longest_duration).to eq(10)
    end
    xit 'calculates the shortest ride' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station: 2, end_date: '8/10/2010', end_station: 2, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)

      expect(Trip.shortest_duration).to eq(8)
    end
    xit 'calculates the Station with the most rides as a starting place' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station: 2, end_date: '8/10/2010', end_station: 2, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/10/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)

      expect(Trip.station_start_max).to eq(2)
    end
    xit 'calculates the Station with the most rides as an ending place' do
      trip_1 = Trip.create!(duration:8, start_date:'8/8/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/9/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/10/2010', start_station: 2, end_date: '8/11/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/10/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)

      expect(Trip.station_end_max).to eq(1)
    end
    xit 'calculates Month by Month breakdown of number of rides with subtotals for each year' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/2/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/3/2010', start_station: 2, end_date: '8/11/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:8, start_date:'8/5/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_6 = Trip.create!(duration:9, start_date:'8/6/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_7 = Trip.create!(duration:10, start_date:'8/7/2010', start_station: 2, end_date: '8/11/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_8 = Trip.create!(duration:5, start_date:'8/8/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_9 = Trip.create!(duration:8, start_date:'8/9/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 4, subscription_type: "Subscriber", zip_code: 22207)
      trip_10 = Trip.create!(duration:9, start_date:'8/10/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_11 = Trip.create!(duration:10, start_date:'8/11/2010', start_station: 2, end_date: '8/11/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_12 = Trip.create!(duration:5, start_date:'8/12/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)

      expect(Trip.number_of_rides_per_month).to eq({ 1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1, 6 => 1, 7 => 1, 8 => 1, 9 => 1, 10 => 1, 11 => 1, 12 => 1 })
      expect(Trip.total_trips_per_year).to eq({ 2010 => 12 })
    end
    xit 'calculates the Most ridden bike with total number of rides for that bike' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/2/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/3/2010', start_station: 2, end_date: '8/11/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:8, start_date:'8/5/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_6 = Trip.create!(duration:9, start_date:'8/6/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)

      expect(Trip.bike_with_most_rides).to eq(6)
    end
    xit 'calculates the Least ridden bike with total number of rides for that bike' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/2/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/3/2010', start_station: 2, end_date: '8/11/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:8, start_date:'8/5/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_6 = Trip.create!(duration:9, start_date:'8/6/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)

      expect(Trip.bike_with_least_rides).to eq(5)
    end
    xit 'calculates the User subscription type breakout with both count and percentage' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/2/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/3/2010', start_station: 2, end_date: '8/11/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:9, start_date:'8/6/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)

      expect(Trip.subscriber_count).to eq(3)
      expect(Trip.subscriber_percent).to eq(60)
      expect(Trip.customer_count).to eq(2)
      expect(Trip.customer_percent).to eq(40)
    end
    xit 'calculates the Single date with the highest number of trips with a count of those trips' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/1/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/1/2010', start_station: 2, end_date: '8/11/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/4/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:9, start_date:'8/6/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)

      expect(Trip.date_with_most_trips).to eq('8/1/2010')
      expect(Trip.most_trips_in_one_day_count).to eq(3)
    end
    xit 'calculates the Single date with the lowest number of trips with a count of those trips' do
      trip_1 = Trip.create!(duration:8, start_date:'8/1/2010', start_station: 1, end_date: '8/9/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22207)
      trip_2 = Trip.create!(duration:9, start_date:'8/1/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)
      trip_3 = Trip.create!(duration:10, start_date:'8/1/2010', start_station: 2, end_date: '8/11/2010', end_station: 1, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_4 = Trip.create!(duration:5, start_date:'8/9/2010', start_station: 2, end_date: '8/11/2010', end_station: 2, bike_id: 6, subscription_type: "Subscriber", zip_code: 22201)
      trip_5 = Trip.create!(duration:9, start_date:'8/9/2010', start_station: 2, end_date: '8/10/2010', end_station: 1, bike_id: 5, subscription_type: "Customer", zip_code: 22406)

      expect(Trip.date_with_least_trips).to eq('8/9/2010')
      expect(Trip.least_trips_in_one_day_count).to eq(2)
    end
  end
end
