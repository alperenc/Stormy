//
//  ViewController.swift
//  Stormy
//
//  Created by Alp Eren Can on 18/07/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit

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
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(APIKey)/")
        let locationURL = NSURL(string: "41.01,28.95?units=ca", relativeToURL: baseURL)
        
        let request = NSURLRequest(URL: locationURL!)
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                switch(httpResponse.statusCode) {
                case 200:
                    let jsonDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? [String: AnyObject]
                    print(jsonDictionary!["daily"]!["data"])
                    let currentWeather = CurrentWeather(currentWeatherDictionary: jsonDictionary!["currently"] as! [String: AnyObject])
//                    let dailyWeather = DailyWeather(dailyWeatherDictionary: jsonDictionary!["daily"]!["data"]![0] as! [String : AnyObject])
                    dispatch_async(dispatch_get_main_queue()) {
                        if let currentTemperature = currentWeather.temperature {
                            self.currentTemperatureLabel?.text = "\(currentTemperature)º"
                        }
                        
                    }
                default:
                    print("GET request not successful. HTTP status code: \(httpResponse.statusCode)")
                }
            } else {
                print("Error: Not a valid HTTP response")
            }
        }
        
        dataTask.resume()
        
        
        iconImageView?.image = UIImage(named: "clear-day")
        summaryLabel?.text = "Clear"
        currentTemperatureLabel?.text = "80º"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

