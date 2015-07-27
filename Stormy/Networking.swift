//
//  Networking.swift
//  Stormy
//
//  Created by Alp Eren Can on 26/07/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import Foundation

class Networking {
    lazy var configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.configuration)
    
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = [String : AnyObject]? -> Void
    
    init(url: NSURL) {
        queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        let request = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            if let httpResponse = response as? NSHTTPURLResponse,
                let dataReturned = data {
                switch(httpResponse.statusCode) {
                case 200:
                    let jsonDictionary = try! NSJSONSerialization.JSONObjectWithData(dataReturned, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject]
                    completion(jsonDictionary)
                default:
                    print("GET request not successful. HTTP status code: \(httpResponse.statusCode)")
                }
            } else {
                print("Error: Not a valid HTTP response")
            }
            
        }//completionHandler: <#T##(NSData?, NSURLResponse?, NSError?) -> Void#>)
        
        dataTask.resume()
    }
}