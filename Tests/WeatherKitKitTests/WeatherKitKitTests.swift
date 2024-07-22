import XCTest
@testable import WeatherKitKit
import CoreLocation

final class WeatherKitKitTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    
    func testHumidity() async {
        let weather = ObservableWeather()
        guard await weather.fetchWeather(for: CLLocation(latitude: 54.4858, longitude: 9.05239)) else {
            XCTFail()
            return
        }
        guard let weather = weather.weather else {
            XCTFail()
            return
        }
        
        print(weather.todaysAverageHumidity)
    }
    
    func testSuntime() async {
        let weather = ObservableWeather()
        guard await weather.fetchWeather(for: CLLocation(latitude: 54.4858, longitude: 9.05239)) else {
            XCTFail()
            return
        }
        guard let weather = weather.weather else {
            XCTFail()
            return
        }
        
        print(weather.dailyForecast.first?.todaysSuntime())
    }
    
    func testNextHourly() async {
        let weather = ObservableWeather()
        guard await weather.fetchWeather(for: CLLocation(latitude: 54.4858, longitude: 9.05239)) else {
            XCTFail()
            return
        }
        guard let weather = weather.weather else {
            XCTFail()
            return
        }
        
        weather.nextHourlyForecasts(count: 5).first!
    }
}
