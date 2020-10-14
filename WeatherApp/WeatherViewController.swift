//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tomasz Paluszkiewicz on 13/10/2020.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

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
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    //MARK: - Networking
    
    func getWeatherData(url: String, parameters: [String : String]){
        
        AF.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                print("Success, data from Weather API are readed")
                
                break
            case .failure(let error):
                print("Connection Issues")
                print(error)
                self.cityLabel.text = "Check Connection"
            }
        }
        
    }
    
    
    
    
    
    //MARK: - JSON Parsing
   

    
    
    
    //MARK: - UI Updates
  
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Problem with GPS Location"
    }

    
    //MARK: - Change City Delegate methods
  
    
    
    
    
    
}


