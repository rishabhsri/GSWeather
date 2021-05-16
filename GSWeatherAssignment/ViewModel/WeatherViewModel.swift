//
//  WeatherViewModel.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 15/05/21.
//

import Foundation

class WeatherViewModel {
    
    private let networkService = APIManager()
    
    var weatherDetail: WeatherModel?
    
    func getWeatherDetailsForCity(for city: String, completion: @escaping (WeatherModel?) -> Void) {
        networkService.getWeatherForCity(city, completion: {[weak self] (weatherInfo) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let weatherDetail = weatherInfo {
                    let model = WeatherModel(weatherInfo: weatherDetail)
                    self.weatherDetail = model
                    completion(model)
                } else {
                    completion(nil)
                }
            }
        })
    }
}
