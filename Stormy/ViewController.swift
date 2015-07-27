//
//  ViewController.swift
//  Stormy
//
//  Created by Alp Eren Can on 18/07/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView?
    @IBOutlet weak var summaryLabel: UILabel?
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var minTemperatureLabel: UILabel?
    @IBOutlet weak var maxTemperatureLabel: UILabel?
    @IBOutlet weak var humidityLabel: UILabel?
    @IBOutlet weak var precipitationLabel: UILabel?
    @IBOutlet weak var windLabel: UILabel?
    
    private let APIKey = "c3947097e9559a92ceb04c984a8a9285"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let forecastAPIClient = ForecastAPIClient(APIKey: APIKey)
        let istanbul = CLLocationCoordinate2DMake(28.94, 41.01)
        forecastAPIClient.getForecast(istanbul) {
            (let currentWeather, let dailyWeather) in
            dispatch_async(dispatch_get_main_queue()) {
                self.summaryLabel?.text = currentWeather?.summary
                if let temperature = currentWeather?.temperature {
                    self.currentTemperatureLabel?.text = "\(temperature)º"
                }
                
                if let humidity = currentWeather?.humidity {
                    self.humidityLabel?.text = "\(humidity)%"
                }
                
                if let precipitation = currentWeather?.precipitation {
                    self.precipitationLabel?.text = "\(precipitation)%"
                }
                
                if let windSpeed = currentWeather?.windSpeed, let windDirection = currentWeather?.windDirection {
                    self.windLabel?.text = "\(windSpeed) \(windDirection)"
                }
                
                if let minTemperature = dailyWeather?.minTemperature {
                    self.minTemperatureLabel?.text = "\(minTemperature)º"
                }
                
                if let maxTemperature = dailyWeather?.maxTemperature {
                    self.maxTemperatureLabel?.text = "\(maxTemperature)º"
                }
            }
        }
        
        iconImageView?.image = UIImage(named: "clear-day")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

