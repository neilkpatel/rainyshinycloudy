//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Neil Patel on 7/12/17.
//  Copyright © 2017 Neil Patel. All rights reserved.
//

// import Foundation // deleted - why?
//singleton class
import CoreLocation

class Location {
//create static variable which is accessible from anywhere in the app. throughout entire, at global level
    static var sharedInstance = Location()
    private init () {} //why this?
    
    var latitude: Double!
    var longitude: Double!
    
    
}
