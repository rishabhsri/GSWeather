//
//  WeatherInfo+Model.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 14/05/21.
//

import Foundation
import CoreData

extension WeatherInfo {
    
    static internal func insertWeatherInfo(_ weatherDetail:WeatherModel, context:NSManagedObjectContext) -> WeatherInfo?
    {
        let weather: WeatherInfo!
        if let weatherInfo = fetchWeatherInfo(NSPredicate(format: "cityName == %@", weatherDetail.cityName!), context: context).first {
            weather = weatherInfo
        } else {
            weather = WeatherInfo(context:context)
        }
        weather.cityName = weatherDetail.cityName
        weather.temperature = weatherDetail.temperature
        weather.sunrise = weatherDetail.sunrise
        weather.sunset = weatherDetail.sunset
        weather.humidity = Int16(weatherDetail.humidity ?? "0") ?? 0
        weather.visibility = Int16(weatherDetail.visibility ?? "0") ?? 0
        weather.windSpeed = Double(weatherDetail.windSpeed ?? "0") ?? 0
        return weather
    }
    
    static internal func fetchWeatherInfo(_ predicate:NSPredicate, context:NSManagedObjectContext) -> [WeatherInfo]
    {
        let fetchRequest:NSFetchRequest = WeatherInfo.fetchRequest()
        fetchRequest.predicate = predicate
        
        var fetchedObjects = [WeatherInfo]()
        do {
            fetchedObjects = try context.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return fetchedObjects
    }
    
    static internal func fetchAllObjects(context:NSManagedObjectContext) -> [WeatherInfo]
    {
        let fetchRequest:NSFetchRequest = WeatherInfo.fetchRequest()
        
        var fetchedObjects = [WeatherInfo]()
        do {
            fetchedObjects = try context.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return fetchedObjects
    }
}
