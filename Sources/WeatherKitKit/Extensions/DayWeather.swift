//
//  File.swift
//  
//
//  Created by Mia Koring on 22.07.24.
//

import Foundation
import WeatherKit
import SwiftChameleon

public extension DayWeather {
    func extremes() -> (Measurement<UnitTemperature>, Measurement<UnitTemperature>) {
        let min = self.lowTemperature.converted(to: .celsius)
        let max = self.highTemperature.converted(to: .celsius)
        
        return (min, max)
    }
    
    func todaysSuntime() -> Int {
        guard let sunrise = self.sun.sunrise else { return 0 }
        guard let sunset = self.sun.sunset else {
            let dayStartVal = Calendar.current.startOfDay(for: Date()).timeIntervalSinceReferenceDate
            let dayEndVal = dayStartVal + (3600 * 24) - 1
            let res = dayEndVal - sunrise.timeIntervalSinceReferenceDate
            
            return res.roundedHours
        }
        
        let interval = sunset - sunrise
        return interval.roundedHours
    }
}
