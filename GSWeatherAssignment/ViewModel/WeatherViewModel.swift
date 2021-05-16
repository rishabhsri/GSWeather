//
//  WeatherViewModel.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 15/05/21.
//

import Foundation

class WeatherViewModel {
    
    fileprivate var networkService: APIManager = APIManager()
    var weatherInfo: WeatherModel?
    
    func getWeatherDetailsForCity(for city: String, completion: @escaping (WeatherModel?) -> Void) {
        networkService.getWeatherForCity(city, completion: {[weak self] (weatherInfo) in
            DispatchQueue.main.async {
                if let weather = weatherInfo {
                    self?.weatherInfo = WeatherModel.init(weatherInfo: weather)
                    completion(self?.weatherInfo)
                } else {
                    completion(nil)
                }
            }
        })
    }
}
