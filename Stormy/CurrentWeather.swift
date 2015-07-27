//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Alp Eren Can on 20/07/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    let summary: String?
    let temperature: Int?
    let humidity: Int?
    let iconName: String?
    let precipitation: Int?
    let windSpeed: Double?
    let windDirection: Int?
    
    init(currentWeatherDictionary: [String: AnyObject]) {
        
        summary = currentWeatherDictionary["summary"] as? String
        
        temperature = currentWeatherDictionary["temperature"] as? Int
        
        if let currentHumidity = currentWeatherDictionary["humidity"] as? Double {
            humidity = Int(currentHumidity * 100)
        } else {
            humidity = nil
        }
        
        iconName = currentWeatherDictionary["icon"] as? String
        
        if let currentPrecipitation = currentWeatherDictionary["precipProbability"] as? Double {
            precipitation = Int(currentPrecipitation * 100)
        } else {
            precipitation = nil
        }
        
        windSpeed = currentWeatherDictionary["windSpeed"] as? Double
        
        windDirection = currentWeatherDictionary["windBearing"] as? Int
        
    }
}
