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

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "2f601ff27d95ea7a9d5f5a7b0db8822c"
    let units = "metric" // or imperial
    
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var onlineIcon: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        temperatureLabel.isHidden = true
        weatherDescription.isHidden = true
    }
    
    
    
    //MARK: - Networking
    
    func getWeatherData(url: String, parameters: [String : String]){
        
        AF.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON from server response: \(json)")
                self.updateWeatherData(json: json)
                
                // Inna technika pobierania danych JSON
                //                let weatherJSON : JSON = JSON(response.data!)
                //                print(weatherJSON)
                //                self.updateWeatherData(json: weatherJSON)
                
                break
            case .failure(let error):
                print("Connection Issues")
                print(error)
                self.cityLabel.text = "Check Internet"
            }
        }
        
    }
    
    
    func weatherIconDownload(){
        
        if let icon = weatherDataModel.onlineIconName {
            
            do {
                let url = URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png")
                let data = try Data(contentsOf: url!)
                self.onlineIcon.image = UIImage(data: data)
                
            }
            catch{
                print(error)
            }
            
        }
    }
    
    
    
    //MARK: - JSON Parsing
    
    func updateWeatherData(json: JSON){
        
        if let weatherCondition = json["weather"][0]["id"].int {
            weatherDataModel.temperature = json["main"]["temp"].int
            weatherDataModel.city = json["name"].string
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherCondition)
            weatherDataModel.onlineIconName = json["weather"][0]["icon"].string
            weatherDataModel.weatherDescription = json["weather"][0]["description"].string
            weatherDataModel.messageError = json["message"].string
            
            updateUIWithWeatherData()
        }
        else {
            weatherDataModel.messageError = json["message"].string
            cityLabel.text = weatherDataModel.messageError?.uppercased()
            print(json)
            if cityLabel.text == "CITY NOT FOUND" {
                
                let alert = UIAlertController(title: "WRONG CITY NAME", message: "Correct a name of the city", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    self.performSegue(withIdentifier: "changeCityName", sender: self)
                })
                
                present(alert, animated: true, completion: nil)
                
                
                
            }
            
        }
    }
    
    
    
    //MARK: - UI Updates
    
    func updateUIWithWeatherData(){
        
        temperatureLabel.isHidden = false
        weatherDescription.isHidden = false
        
        cityLabel.text = weatherDataModel.city?.uppercased()
        weatherDescription.text = weatherDataModel.weatherDescription?.uppercased()
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName!)
        temperatureLabel.text = "\(weatherDataModel.temperature!)°"
        
        weatherIconDownload()
        
        
        
        
    }
    
    
    
    //MARK: - Location Manager Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "units" : units, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Problem with GPS Location"
    }
    
    
    
    //MARK: - Change City Delegate methods
    
    func userEnteredANewCityName(city: String) {
        
        let params : [String : String] = ["q" : city, "units" : units, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    
    
}


