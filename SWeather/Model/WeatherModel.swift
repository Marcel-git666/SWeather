//
//  WeatherModel.swift
//  SWeather
//
//  Created by Marcel Mravec on 26.03.2023.
//

import Foundation

struct WeatherModel {
    let weatherText: String
    let weatherIcon: Int
    let temperature: Double
    let mobileLink: String
    let date: String
    let hasPrecipitation: Bool
    let precipitationType: String?
    let apparentTemperature: Double
    let visibility: Double
    
    var conditionName: String {
        switch weatherIcon {
        case 1:
            return "01-s.png"
            
        default:
            return "02-s.png"
        }
    }
}
