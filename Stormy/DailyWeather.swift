//
//  DailyWeather.swift
//  Stormy
//
//  Created by Alp Eren Can on 20/07/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import Foundation

struct DailyWeather {
    
    let summary: String?
    let minTemperature: Int?
    let maxTemperature: Int?
    
    init(dailyWeatherDictionary: [String: AnyObject]) {
        summary = dailyWeatherDictionary["summary"] as? String
        minTemperature = dailyWeatherDictionary["temperatureMin"] as? Int
        maxTemperature = dailyWeatherDictionary["temperatureMax"] as? Int
    }
}