//
//  WeatherManager.swift
//  SWeather
//
//  Created by Marcel Mravec on 27.03.2023.
//

import Foundation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailedWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://dataservice.accuweather.com/currentconditions/v1/"
     
    func fetchWeather(cityKey: String) {
        let urlString = "\(weatherURL)\(cityKey)?apikey=\(K.apiKey)&details=true"
  
        print(urlString)
        performRequest(with: urlString)
    }
    
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailedWithError(error: error!)
                    return
                }
                if let safeData = data {
                    print(safeData.debugDescription)
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        do {
            let decodedData = try JSONDecoder().decode([WeatherData].self, from: weatherData)
            let weatherText = decodedData[0].WeatherText
            let weatherIcon = decodedData[0].WeatherIcon
            let temperature = decodedData[0].Temperature.Metric.Value
            let date = decodedData[0].LocalObservationDateTime
            let mobileLink = decodedData[0].MobileLink
            let hasPrecipitation = decodedData[0].HasPrecipitation
            let precipitationType = decodedData[0].PrecipitationType
            let apparentTemperature = decodedData[0].ApparentTemperature.Metric.Value
            let visibility = decodedData[0].Visibility.Metric.Value
            let weather = WeatherModel(weatherText: weatherText, weatherIcon: weatherIcon, temperature: temperature, mobileLink: mobileLink, date: date, hasPrecipitation: hasPrecipitation, precipitationType: precipitationType, apparentTemperature: apparentTemperature, visibility: visibility)
            print(weather)
            return weather
            
        } catch {
            delegate?.didFailedWithError(error: error)
            return nil
        }
        
    }
    
    
    
}
