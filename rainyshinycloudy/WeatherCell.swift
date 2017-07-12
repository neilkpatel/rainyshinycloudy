//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Neil Patel on 7/11/17.
//  Copyright © 2017 Neil Patel. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    //pass in forecast of Forecast class, setup IB outlets to pull data from instance of forecast
    //don't do ones with underscores
    func configureCell(forecast: Forecast) {
    lowTemp.text = forecast.lowTemp
    highTemp.text = forecast.highTemp
    weatherType.text = forecast.weatherType
    weatherIcon.image = UIImage(named: forecast.weatherType) //name of the weathertype is name of image file
    dayLabel.text = forecast.date
        
    }

}


//setup IB outlets, then setup function to configure IBOutlets with data
