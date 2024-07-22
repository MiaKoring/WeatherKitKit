//
//  File.swift
//  
//
//  Created by Mia Koring on 22.07.24.
//

import Foundation
import WeatherKit
import CoreLocation
import SwiftUI

@Observable
public class Zapdos {
    public static let shared = Zapdos()
    
    private let service = WeatherService()
    
    public var weather: Weather? = nil
    
    public func fetchWeather(for location: CLLocation) async -> Bool {
        guard let res = try? await service.weather(for: location) else { return false }
        self.weather = res
        return true
    }
    
    public init() {}
}
