//
//  DetailViewController.swift
//  weatherdemo
//
//  Created by iMac on 2/18/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
 
    var weather: WeatherSub!
    
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblFeels: UILabel!
    @IBOutlet weak var lblSky: UILabel!
    @IBOutlet weak var lblSkyDescription: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUIwithData()
    }
    
    private func setupUIwithData() {
        lblTemperature.text = "\(weather.main?.temp ?? 0)"
        lblFeels.text = "\(weather.main?.feels_like ?? 0)"
        
        if let skyinfos = weather.weather, skyinfos.count > 0 {
            lblSky.text = skyinfos[0].main
            lblSkyDescription.text = skyinfos[0].description
        }
        
        if let wind = weather.wind {
            lblWindSpeed.text = "\(wind.speed ?? 0)"
        }
    }
}
