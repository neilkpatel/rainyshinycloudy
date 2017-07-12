//
//  ViewController.swift
//  rainyshinycloudy
//
//  Created by Neil Patel on 7/6/17.
//  Copyright © 2017 Neil Patel. All rights reserved.
//

import UIKit
import CoreLocation
//and implement CLLocationManagerDelegate
import Alamofire


class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //delegate tells tableview how it is supposed to handle data, and the datasource is the data
    //add in delegate functions: 3 main ones to know - 1) number of sections in tableview, 2) number of rows in section, 3) cell for row at indexpath
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather! //empty class of type CurrentWeather, creates generic class of Current Weather
    var forecast: Forecast! //declaring instance of Forecast
    var forecasts = [Forecast]() //instantiating right off the bat, array you ran loop to add to
    
//we need to implement the tableview delegate methods - delegate and datasource
//tableview not loading data yet


    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() //works when app is in use, not always
        locationManager.startMonitoringSignificantLocationChanges()
        
//add delegate to tableview, delegate will pass it in and handle it for us. let's build and run and see if that fixed the problem. 
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        //forecast = Forecast() //instantiated an empty forecast class. NEVERMIND. premature instantiation.
        

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) { //run before downloading weather details
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    //if authorized location, run code. if not, request authorization then run code
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse { //==
            currentLocation = locationManager.location //save location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails { //this can only run once location d/l an saved in singleton class
                self.downloadForecastData {
                    //setup UI to download weather details
                    self.updateMainUI()
                }
            }
            //now location is accessible anywhere in the app
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus() //call function again so your location will be saved. LOGIC!
        }
    }
    
    
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //download forecast weather data for TableView
        let forecastURL = URL(string: FORECAST_URL)! //forced unwrapping because you are sure you have FORECAST_URL because in Constants file
        Alamofire.request(forecastURL).responseJSON { response in //! here unpwraps forecastURL which was an optional???
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,Any> {
                if let list = dict["list"] as? [Dictionary<String,Any>] {
            //cast as array
            //casting value as swift dictionary of string and any object
            //need to run a few times to download data for each day
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj) //creating weatherDict, adding to forecasts array
                        //everytime i find dictionary in array, run loop and pass dictionary into another dictionary
                        self.forecasts.append(forecast)
                        print(obj)
                        
                        //brilliant. adding lists which is 10-day forecast into forecasts array. adding each forecast.
                    }
                    self.forecasts.remove(at:0) //remove first day of forecast which is today
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //number of columns
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //number of rows
        return forecasts.count //need to retun 10 cells worth of data, will count number of dicitonaries in forecasts
    }
    //don't want to load tableview cells that aren't there yet, so just show what's around the screen
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row] //each cell that is created gets indexpath. first cell 0, 1, 2, etc
            cell.configureCell(forecast: forecast)
            return cell //create cell, give it index path, return it
            
        } else { return WeatherCell()
            
        }
        
        //give tableviewcell a re-use identifier
        //tableview is loaded but not re-loaded
    }
    
    func updateMainUI () {
        //create instance of CurrentWeather
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)" //UI label needs text
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
   
}




//Weather app - connect to internet, downloads forecast data from internet
//app will find your GPS coordinates, weather api to pull city name, pull weather data
    //what if it pulls your location, bar, event, etc, 













//trouble with alamofire as versions change. xcode 8 released, swift 3 released.
//in podfile, instead of pulling branch from swift 3 get rid of those lines
//go to alamofire github page, installation with cocoa pods - pod alamofire 4.0
//cd into directory - pod update in terminal
//install cocoa pods, use release master version of alamofire (4.0)
//did finish launching with options: return true (delegate)
//syntax for alamofire has changed. Alamofire.request(URL)
//in closure - completed: @escaping DownloadComplete

