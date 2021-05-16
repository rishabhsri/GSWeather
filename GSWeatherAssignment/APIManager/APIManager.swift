//
//  APIManager.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 14/05/21.
//

import Foundation

struct APIManager {
    private let baseURLString = "https://api.openweathermap.org/data/2.5/weather?q="
    private let apiKey = "b928f96013f8643dd0f2556129b33f2b"
    let session = URLSession.shared

    // MARK: - General Methods
    private func weatherAPIURL(_ cityName: String) -> URL {
        let weatherInfoUrl =  baseURLString + "\(cityName)&APPID=\(apiKey)"
        guard let finalURL = URL(string: weatherInfoUrl) else {
            fatalError("URL must be created!")
        }
        return finalURL
    }
    
    //MARK: Get Food categories...
    func getWeatherForCity(_ cityName: String, completion: @escaping (WeatherDetail?) -> Void) {
        let url = self.weatherAPIURL(cityName)
        session.dataTask(with: url, completionHandler: {(data, _, error) in
            if error == nil, let responseData = data {
                var weatherDetails: WeatherDetail?
                do {
                    weatherDetails = try JSONDecoder().decode(WeatherDetail.self, from: responseData)
                } catch {
                    print("Could not parsed...")
                }
                completion(weatherDetails)
            } else {
                completion(nil)
            }
        }).resume()
    }
}
