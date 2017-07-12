//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by Neil Patel on 7/10/17.
//  Copyright © 2017 Neil Patel. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    private var  _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!

    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
        
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
        
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    //initialize weatherDict, setting variables in this file.
    init(weatherDict: Dictionary<String,Any>) {
        if let temp = weatherDict["temp"] as? Dictionary<String,Any> {
            if let min = temp["min"] as? Double {
                
                let kelvinToFarenheitPreDevision = (min * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDevision/10))
                self._lowTemp = "\(kelvinToFarenheit)" //turning double into a string
                
            }
            
            if let max = temp["max"] as? Double {
                
                let kelvinToFarenheitPreDevision = (max * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDevision/10))
                self._highTemp = "\(kelvinToFarenheit)" //turning double into a string
        }
            
        
    }
        
        //call a new dictionary
        
        if let weather = weatherDict["weather"] as? [Dictionary<String,Any>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date) //unix converted date
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
            
        }
    }
    
}
//this is our forecast class, going into tableiew
//inside dictionaries, there are Keys, Values

//get day of the week from date, and then type day of the week instead of creating / removing
//extensions must be built outside of your class
extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" //code that says I want full name of the day of the week
        return dateFormatter.string(from: self) //getting date from this viewcontroller
        
    }
}

//creating date, passing in unix timestamp number, then run that date through function which will remove everything except for day of the week
