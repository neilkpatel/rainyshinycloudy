//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Neil Patel on 7/8/17.
//  Copyright © 2017 Neil Patel. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat=\(Location.sharedInstance.latitude!)"
let LONGITUDE = "&lon=\(Location.sharedInstance.longitude!)"

//*** only worked after you explicitly unwrapped via !. Why is that???

let APP_ID = "&appid="
let API_KEY = "48cdab8b66cb3d863afdf33c45aa273f"

typealias DownloadComplete = () -> () //this will tell fcn when it is complete

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=48cdab8b66cb3d863afdf33c45aa273f"


//! after latitude and longitude to force unwrap because we know we will have this and we are calling it before view loads and we check for permissions. we aren't d/l from server, so we know we will have loccation.

//need to pass in singleton class data where latitude and longitude data is
