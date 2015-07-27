//
//  ForecastAPIClient.swift
//  Stormy
//
//  Created by Alp Eren Can on 27/07/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import Foundation
import CoreLocation

struct ForecastAPIClient {
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    typealias WeatherForecastCompletion = (CurrentWeather?, DailyWeather?) -> Void
    
    init(APIKey: String) {
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    func getForecast(location: CLLocationCoordinate2D, completion: WeatherForecastCompletion) {
        if let forecastURL = NSURL(string: "\(location.latitude),\(location.longitude)?units=ca", relativeToURL: forecastBaseURL) {
            let networking = Networking(url: forecastURL)
            
            networking.downloadJSONFromURL {
                (let JSONDictionary) in
                let currentWeather: CurrentWeather?
                let dailyWeather: DailyWeather?
                if let currentWeatherDictionary = JSONDictionary?["currently"] as? [String: AnyObject] {
                    currentWeather = CurrentWeather(currentWeatherDictionary: currentWeatherDictionary)
                } else {
                    currentWeather = nil
                }
                if let dailyWeatherForecast = JSONDictionary?["daily"] as? [String: AnyObject] {
                    if let dailyWeatherDictionary = dailyWeatherForecast["data"]![0] as? [String: AnyObject] {
                        dailyWeather = DailyWeather(dailyWeatherDictionary: dailyWeatherDictionary)
                    } else {
                        dailyWeather = nil
                    }
                } else {
                    dailyWeather = nil
                }
                completion(currentWeather, dailyWeather)
            }
            
        } else {
            print("Could not construct a valid URL.")
        }
    }
}
