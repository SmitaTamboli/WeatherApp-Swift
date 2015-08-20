//
//  ParsingManager.swift
//  WeatherApp
//
//  Created by Smita Tamboli on 8/19/15.
//  Copyright (c) 2015 Cybage. All rights reserved.
//

import UIKit

class ParsingManager: NSObject {
   
    func parseData(dataArray: NSArray) -> [WeatherReport] {
        var weatherArray: [WeatherReport] = []
        
        for dictionary in dataArray as! [NSDictionary] {
            var weatherReport:WeatherReport = WeatherReport()
            
            if let date:String = dictionary["dt_txt"] as? String {
                weatherReport.dt_txt = date
            }
            if let main = dictionary["main"] as? NSDictionary {
                
                weatherReport.grnd_level = String(stringInterpolationSegment: (main["grnd_level"] as? Double)!)
                weatherReport.humidity = String(stringInterpolationSegment: (main["humidity"] as? Int)!)
                weatherReport.pressure = String(stringInterpolationSegment: (main["pressure"] as? Double)!)
                weatherReport.sea_level = String(stringInterpolationSegment: (main["sea_level"] as? Double)!)
                weatherReport.temp = String(stringInterpolationSegment: (main["temp"] as? Double)!)
                weatherReport.temp_kf = String(stringInterpolationSegment: (main["temp_kf"] as? Double)!)
                weatherReport.temp_max = String(stringInterpolationSegment: (main["temp_max"] as? Double)!)
                weatherReport.temp_min = String(stringInterpolationSegment: (main["temp_min"] as? Double)!)
            }
            if let weather = dictionary["weather"] as? NSArray {
                for weatherDictionary in weather as! [NSDictionary] {
                    weatherReport.discription = (weatherDictionary["description"] as? String)!
                    weatherReport.icon = (weatherDictionary["icon"] as? String)!
                }
            }
            
            if let wind = dictionary["wind"] as? NSDictionary {
                weatherReport.deg = String(stringInterpolationSegment: (wind["deg"] as? Double)!)
                weatherReport.speed = String(stringInterpolationSegment: (wind["speed"] as? Double)!)
            }
            
            weatherArray.append(weatherReport)
        }
        
        return weatherArray
    }
}
