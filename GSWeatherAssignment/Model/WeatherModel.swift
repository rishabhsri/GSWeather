//
//  WeatherModel.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 15/05/21.
//

import Foundation

class WeatherModel {
    var cityName: String?
    var windSpeed: String?
    var temperature: String?
    var sunrise: String?
    var sunset: String?
    var humidity: String?
    var visibility: String?
    
    init(weatherInfo: WeatherDetail) {  // Populate data from API model...
        self.cityName = weatherInfo.name
        self.temperature = Utility.tempInCelcius(from: weatherInfo.main.temp)
        self.sunrise = Utility.getDateFromDouble(doubleDate: weatherInfo.sys.sunrise)
        self.sunset = Utility.getDateFromDouble(doubleDate: weatherInfo.sys.sunset)
        self.humidity = String(weatherInfo.main.humidity)
        self.visibility = String(weatherInfo.visibility)
        self.windSpeed = String(weatherInfo.wind.speed)
    }
    
    init(weatherInfo: WeatherInfo) {    // Populate model from core data model...
        self.cityName = weatherInfo.cityName
        self.temperature = weatherInfo.temperature
        self.sunrise = weatherInfo.sunrise
        self.sunset = weatherInfo.sunset
        self.humidity = String(weatherInfo.humidity)
        self.visibility = String(weatherInfo.visibility)
        self.windSpeed = String(weatherInfo.windSpeed)
    }
}
