//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Smita on 28/01/15.
//  Copyright (c) 2015 Cybage. All rights reserved.
//

import UIKit
import Foundation

class NetworkManager: NSObject{
    
    var data = NSMutableData();
    var weatherDetail:[WeatherReport] = []
   
    override init() {
        
    }

    func makeConnection(searchText:String ,complition:([WeatherReport]?, NSError?, String?)->Void) -> Void {
        
        let urlAsString = "http://api.openweathermap.org/data/2.5/forecast?q=\(searchText)&cnt=14&APPID=dd3546328de71c05810fc4c0e76cf1b9"
        
        let url = NSURL(string: urlAsString)!
        let urlSession = NSURLSession.sharedSession()
        
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            
            let weatherArray:NSArray = [WeatherReport]()
            var errMessage:String = ""
             var parsingManager = ParsingManager()
            
            var err: NSError?
            
            let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
            if (error != nil) {

                complition(weatherArray as? [WeatherReport], error, errMessage)
                
            } else if jsonResult.allKeys.count == 2 {
                
                if let message:String = jsonResult["message"] as? String {
                    errMessage = message
                }
                
                complition(weatherArray as? [WeatherReport], error, errMessage)
            } else {
                
                let weatherArray:NSArray = jsonResult["list"] as! NSArray
                
                complition(parsingManager.parseData(weatherArray), error, errMessage)
            }
            
        })
        
        jsonQuery.resume()
        
    }
}