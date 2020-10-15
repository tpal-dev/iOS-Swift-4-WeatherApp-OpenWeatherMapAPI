//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Tomasz Paluszkiewicz on 13/10/2020.
//

import UIKit

class WeatherDataModel {

    var temperature : Int?
    var condition : Int?
    var city : String?
    var weatherIconName : String?
    var onlineIconName : String?
    var weatherDescription : String?
    var messageError: String?
    
    
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    
        case 0...212 :
            return "tstorm1"
        
        case 213...232 :
            return "tstorm3"
        
        case 300...321 :
            return "drizzle"
        
        case 500...531 :
            return "shower3"
        
        case 601...700 :
            return "snow4"
        
        case 701...771 :
            return "fog"
        
        case 781 :
            return "tstorm3"
        
        case 800 :
            return "sunny"
        
        case 801...804 :
            return "cloudy2"
        
        default :
            return "Cloud-Refresh"
        }

    }
}
