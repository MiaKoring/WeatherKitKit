//
//  File.swift
//  
//
//  Created by Mia Koring on 22.07.24.
//

import Foundation
import WeatherKit
import SwiftChameleon

extension HourWeather {
    
    ///temp as Double in Celsius
    var temp: Double{
        self.temperature.converted(to: .celsius).value
    }
    
    var intTemp: Int{
        self.temp.roundedInt
    }
}
