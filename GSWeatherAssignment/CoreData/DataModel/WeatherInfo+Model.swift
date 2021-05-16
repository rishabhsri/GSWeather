//
//  WeatherInfo+Model.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 14/05/21.
//

import Foundation
import CoreData

extension WeatherInfo {
    
    static internal func storeWeatherInfo(weatherDetail:WeatherModel)
    {
        let context = CoreDataManager.shared.viewContext
        let predicate = NSPredicate(format: "cityName == %@", weatherDetail.cityName)
        
        let weather: WeatherInfo!
        if let weatherInfo = WeatherInfo.fetchWeatherInfo(predicate: predicate)?.first {
            weather = weatherInfo
        } else {
            weather = WeatherInfo(context:context)
            weather.cityName = weatherDetail.cityName
        }
        
        weather.temperature = weatherDetail.temperature
        weather.sunrise = weatherDetail.sunrise
        weather.sunset = weatherDetail.sunset
        weather.humidity = Int16(weatherDetail.humidity) ?? 0
        weather.visibility = Int16(weatherDetail.visibility) ?? 0
        weather.windSpeed = Double(weatherDetail.windSpeed) ?? 0
        
        CoreDataManager.shared.saveContext()
    }
    
    static internal func fetchWeatherInfo(predicate:NSPredicate) -> [WeatherInfo]? {
        let context = CoreDataManager.shared.viewContext
        
        let fetchRequest:NSFetchRequest = WeatherInfo.fetchRequest()
        fetchRequest.predicate = predicate
        let fetchedObjects = try? context.fetch(fetchRequest)
        return fetchedObjects
    }
    
    static internal func fetchAllObjects() -> [WeatherInfo]? {
        let context = CoreDataManager.shared.viewContext
        let fetchRequest: NSFetchRequest = WeatherInfo.fetchRequest()
        let fetchedObjects = try? context.fetch(fetchRequest)
        return fetchedObjects
    }
    
    static func deleteObject(city: String) {
        let context = CoreDataManager.shared.viewContext
        let predicate = NSPredicate(format: "cityName == %@", city)
        if let weatherInfo = WeatherInfo.fetchWeatherInfo(predicate: predicate)?.first {
            context.delete(weatherInfo)
            CoreDataManager.shared.saveContext()
        }
    }
}
