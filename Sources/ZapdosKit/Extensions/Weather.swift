//
//  File.swift
//  
//
//  Created by Mia Koring on 22.07.24.
//

import Foundation
import WeatherKit

public extension Weather {
    var currentTempCel: Measurement<UnitTemperature> {
        let currentTemp = self.currentWeather.temperature
        return currentTemp.converted(to: UnitTemperature.celsius)
    }
    
    var intCurrentTemp: Int {
        Double(self.currentTempCel.value.float).roundedInt
    }
    
    ///current humidity in percent
    var currentHumidity: Double {
        self.currentWeather.humidity * 100
    }
    
    ///current humidity in percent
    var intCurrentHumidity: Int {
        self.currentHumidity.roundedInt
    }
    
    ///speed in kph
    var currentWindspeed: Double {
        self.currentWeather.wind.speed.converted(to: .kilometersPerHour).value
    }
    
    var intCurrentWindspeed: Int {
        self.currentWindspeed.roundedInt
    }
    
    var currentCondition: WeatherCondition {
        self.currentWeather.condition
    }
    
    func extremes() -> (Measurement<UnitTemperature>, Measurement<UnitTemperature>)? {
        self.todaysDailyForecast?.extremes()
    }
    
    func intExtremes() -> (Int, Int)? {
        guard let (min, max) = self.extremes() else { return nil }
        return (Double(min.value.float).roundedInt, Double(max.value.float).roundedInt)
    }
    
    /// average humidity in percent
    var todaysAverageHumidity: Double {
        let values = self.todaysHourlyHumidity
        
        print(values.count)
        
        let average = values.reduce(0.0, { (currentSum, number) in
            currentSum + number
        }) / values.count.double
        
        return average * 100.0
    }
    
    var intAverageHumidity: Int {
        self.todaysAverageHumidity.roundedInt
    }
    
    /// median humidity in percent
    var todaysMedianHumidity: Double {
        let values = self.todaysHourlyHumidity
        
        let sorted = values.sorted()
        
        return sorted[sorted.count / 2] * 100.0
    }
    
    var intMedianHumidity: Int {
        self.todaysMedianHumidity.roundedInt
    }
    
    var todaysHourlyHumidity: [Double] {
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date(timeIntervalSinceReferenceDate: startDate.timeIntervalSinceReferenceDate + (3600 * 24) - 1)
        let values = self.hourlyForecast.compactMap({
            if (startDate...endDate).contains($0.date) { return $0.humidity }
            return nil
        })
        return values
    }
    
    ///Todays Suntime rounded in hours
    var todaysSuntime: Int? {
        return self.todaysDailyForecast?.todaysSuntime()
    }
    
    var todaysDailyForecast: DayWeather? {
        let todaysForecast = self.dailyForecast.first(where: {
            Calendar.current.isDateInToday($0.date)
        })
        return todaysForecast
    }
    
    ///average windspeed in kph
    var todaysAverageWindspeed: Double {
        let values = self.todaysHourlyWindspeed
        let sum = values.reduce(0.0, { (currentSum, value) in
            currentSum + value.speed.converted(to: .kilometersPerHour).value
        })
        return sum / values.count.double
    }
    
    var intAverageWindspeed: Int {
        self.todaysAverageWindspeed.roundedInt
    }
    
    ///median windspeed in kph
    var todaysMedianWindspeed: Double {
        let values = self.todaysHourlyWindspeed
        let sorted = values.sorted(by: {$0.speed < $1.speed})
        
        return sorted[values.count / 2].speed.converted(to: .kilometersPerHour).value
    }
    
    var intMedianWindspeed: Int {
        self.todaysAverageWindspeed.roundedInt
    }
    
    ///precipation-amount in millimeters
    var precipitionAmount: Int? {
        let today = self.todaysDailyForecast
        return today?.precipitationAmount.converted(to: .millimeters).value.roundedInt
    }
    
    var todaysHourlyWindspeed: [Wind] {
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date(timeIntervalSinceReferenceDate: startDate.timeIntervalSinceReferenceDate + (3600 * 24) - 1)
        let values = self.hourlyForecast.compactMap({
            if (startDate...endDate).contains($0.date) { return $0.wind }
            return nil
        })
        
        return values
    }
    
    ///starts by default at the beginning of the current hour
    func nextHourlyForecasts(count: Int,
                             startingAt: Date = Calendar.current.date(bySetting: .minute, value: 0, of: Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate - 3599)) ?? Date()
    ) -> [HourWeather] {
        if count <= 0 {
            return []
        }
        let end = Date(timeIntervalSinceReferenceDate: startingAt.timeIntervalSinceReferenceDate + (3600.0 * count.double) - 1)
        let res = self.hourlyForecast.compactMap({
            if (startingAt...end).contains($0.date) {
                return $0
            }
            return nil
        })
        return res
    }
}
