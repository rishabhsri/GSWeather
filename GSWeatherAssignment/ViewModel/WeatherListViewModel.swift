//
//  WeatherListViewModel.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 16/05/21.
//

import Foundation

class WeatherListViewModel {
    
    var weatherDataList = [WeatherModel]()
    
    func createDataSource() {
        if let weatherDataArray = WeatherInfo.fetchAllObjects() {
            weatherDataArray.forEach { (weatherInfo) in
                weatherDataList.append(WeatherModel(weatherInfo: weatherInfo))
            }
        }
    }
    
    func deleteWeather(for model: WeatherModel) {
        WeatherInfo.deleteObject(city: model.cityName)
        weatherDataList = weatherDataList.filter({ $0.cityName != model.cityName })
    }
}
