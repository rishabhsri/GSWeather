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
        let weatherDataArray = WeatherInfo.fetchAllObjects()
        if let objCount = weatherDataArray?.count, objCount > 0 {
            weatherDataArray?.forEach({ (weatherObj) in
                weatherDataList.append(WeatherModel.init(weatherInfo: weatherObj))
            })
        }
    }
    
    func deleteWeather(for model: WeatherModel) {
        WeatherInfo.deleteObject(city: model.cityName ?? "")
        weatherDataList = weatherDataList.filter({ $0.cityName != model.cityName })
    }
}
