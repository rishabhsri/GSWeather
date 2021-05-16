//
//  WeatherDetail.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 14/05/21.
//

import Foundation


// MARK: - WeatherDetail
struct WeatherDetail: Decodable {
    let main: MainClass
    let wind: Wind
    let visibility: Int
    let sys: Sys
    let name: String
}

// MARK: - MainClass
struct MainClass: Decodable {
    let temp, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let sunrise: Double
    let sunset: Double
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

