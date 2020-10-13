//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tomasz Paluszkiewicz on 13/10/2020.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "2f601ff27d95ea7a9d5f5a7b0db8822c"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
    }
    
    
    
    //MARK: - Networking
    

    
    
    
    
    
    //MARK: - JSON Parsing
   

    
    
    
    //MARK: - UI Updates
  
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
   
    
    
    

    
    //MARK: - Change City Delegate methods
  
    
    
    
    
    
}


