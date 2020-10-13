//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Tomasz Paluszkiewicz on 13/10/2020.
//

import UIKit




class ChangeCityViewController: UIViewController {
    
    
    @IBOutlet weak var changeCityTextField: UITextField!

    
    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
