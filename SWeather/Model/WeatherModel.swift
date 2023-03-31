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
    
    var dateTime: String {
        let componets = date.split(separator: "T")
        let dateComponents = componets[0].split(separator: "-")
        let timeComponents = componets[1].split(separator: ":")
        let finalDateAndTime = "\(dateComponents[2]).\(dateComponents[1]).\(dateComponents[0]) - \(timeComponents[0]):\(timeComponents[1])"

        print(finalDateAndTime)

        return finalDateAndTime
    }
}
