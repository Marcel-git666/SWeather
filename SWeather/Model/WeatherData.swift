//
//  WeatherData.swift
//  SWeather
//
//  Created by Marcel Mravec on 26.03.2023.
//

import Foundation


// For JSON Decoding

struct WeatherData: Decodable {
    let LocalObservationDateTime: String
    let WeatherText: String
    let WeatherIcon: Int
    let Temperature: UnitType
    let HasPrecipitation: Bool
    let PrecipitationType: String?
    let MobileLink: String
    let ApparentTemperature: UnitType
    let Visibility: UnitType
}

struct UnitType: Decodable {
    let Metric: Value
}

struct Value: Decodable {
    let Value: Double
    let Unit: String
    let UnitType: Int
}


