//
//  LocationData.swift
//  SWeather
//
//  Created by Marcel Mravec on 26.03.2023.
//

import Foundation

// For JSON Decoding

struct LocationData: Decodable {
    var Key: String
    var LocalizedName: String
    var Country: CountryName
}

struct CountryName: Decodable {
    let ID: String
    let LocalizedName: String
}
