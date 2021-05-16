//
//  WeatherInfo+Parser.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 14/05/21.
//

import UIKit

extension WeatherInfo {
    
    static func saveWeatherInfo(info:WeatherModel) -> WeatherInfo? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let modelObject = WeatherInfo.insertWeatherInfo(info, context: context)

        WeatherInfo.saveContext(context)
        
        //return saved objects
        return modelObject
    }
    
    static func fetchAllObjects() -> [WeatherInfo]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        return WeatherInfo.fetchAllObjects(context: context)
    }
    
    static func deleteObject(city: String){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            if let weatherInfo = fetchWeatherInfo(NSPredicate(format: "cityName == %@", city), context: context).first {
                context.delete(weatherInfo)
                appDelegate.saveContext()
            }
        }
    }
}
