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
    
    
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    
        case 0...300 :
            return "tstorm1"
        
        case 301...500 :
            return "light_rain"
        
        case 501...600 :
            return "shower3"
        
        case 601...700 :
            return "snow4"
        
        case 701...771 :
            return "fog"
        
        case 772...799 :
            return "tstorm3"
        
        case 800 :
            return "sunny"
        
        case 801...804 :
            return "cloudy2"
        
        default :
            return "dunno"
        }

    }
}
