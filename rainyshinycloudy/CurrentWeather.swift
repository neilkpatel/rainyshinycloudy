//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Neil Patel on 7/8/17.
//  Copyright © 2017 Neil Patel. All rights reserved.
//

import Foundation

import UIKit
import Alamofire //imports the cocoapods. imported into weather class. need to create function that will download weather data and set values.

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = "" //if there is no value, change it to empty string so there is something so no crash. ensures code is safe. if when we pull from API and if cityName == nil, then we will set cityName to be an empty string.
        }
        return _cityName
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    //date gets tricky. need to use dateformatter
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateformatter = DateFormatter() //creating instance of DateFormatter that is empty
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .none
        let currentDate = dateformatter.string(from: Date()) //create string from current date and dateformatter keeping track of what it looks like.
        self._date = "Today, \(currentDate)"
        
        return _date //pulling data from the device itself
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //initialize URL to tell alamofire where to download from
        //completion handler, way to capture responses, etc
        // we don't care when it is complete because we already created a completed function
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON { response in  //after request, give response
            let result = response.result //every request has response, every response has result
            
            //now from response, let's create a dictionary, casted as Dictionary of String, values will be any object
            if let dict = result.value as? Dictionary<String, Any> {
                
                //find value name, passing value in as String
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized //makes sure first letter of name is always capitalized. KEWL
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    if let main = weather[0]["main"] as? String { //[0] beause array
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                    
                }
             
                
                if let main = dict["main"] as? Dictionary<String, Any> {
                    if let currentTemperature = main["temp"] as? Double {
                        let kelvinToFarenheitPreDevision = (currentTemperature * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDevision/10))
                        self._currentTemp = kelvinToFarenheit
                        print(self._currentTemp)
                    }
                }
            }
            
            
            completed()

        }
        
    }
    
    //setup something to tell your fcn when it is finished
    //haven't made download complete yet, so go back to constants
    
}

//declaring variables, but encapsulating / data hiding so that only our download function can access these variables and only in this file. We will need a city name








