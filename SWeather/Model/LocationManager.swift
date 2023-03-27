//
//  WeatherManager.swift
//  SWeather
//
//  Created by Marcel Mravec on 26.03.2023.
//

import Foundation

protocol LocationManagerDelegate {
    func didUpdateLocation(_ locationManager: LocationManager, location: [LocationModel])
    func didFailedWithError(error: Error)
}

struct LocationManager {
    
    var delegate: LocationManagerDelegate?

    let autoCompleteLocation = "https://dataservice.accuweather.com/locations/v1/cities/autocomplete"

    func fetchLocations(autocompleteSearch: String) {
        let urlString = "\(autoCompleteLocation)?apikey=\(K.apiKey)&q=\(autocompleteSearch)"
        print("Fetching locations...")
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailedWithError(error: error!)
                    print("Chyba dekodování..")
                    return
                }
                if let safeData = data {
                    if let locations = parseJSON(safeData) {
                        delegate?.didUpdateLocation(self, location: locations)
                    }
                    
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ locationData: Data) -> [LocationModel]? {
        do {
            let decodedData = try JSONDecoder().decode([LocationData].self, from: locationData)
            var arrayOfLocations: [LocationModel] = []
            for loc in decodedData {
                let id = loc.Key
                let name = loc.LocalizedName
                let location = LocationModel(key: Int(id) ?? 0, name: name)
                
                arrayOfLocations.append(location)
            }
            print(arrayOfLocations)
            return arrayOfLocations
            
        } catch {
            delegate?.didFailedWithError(error: error)
            return nil
        }
        
    }
        
    
}

