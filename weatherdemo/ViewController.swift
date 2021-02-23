//
//  ViewController.swift
//  weatherdemo
//
//  Created by iMac on 2/18/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import Reachability
import RxCocoa
import RxSwift
import PKHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var tfCity: UITextField!
    
    
    let disposeBag = DisposeBag()
    
    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTapView))
        view.addGestureRecognizer(tapView)
        view.isUserInteractionEnabled = true
    }
    
    // MARK: - weather information from https://api.openweathermap.org
    private func getWeather(city: String) {
        self.showLoader()
        Service.shared().getWeatherList(city: city).subscribe(onNext: { (weather) in
            self.weather = weather
        }, onError: { (error) in
            self.hideLoader()
        }, onCompleted: {
            self.hideLoader()
            self.navToDetail()
        }).disposed(by: disposeBag)
    }
    
    @objc func onTapView() {
        self.view.endEditing(true)
    }
    
    @IBAction func onClickLookup(_ sender: Any) {
        let city = tfCity.text!
        if city == "" {
            return
        }
        
        self.view.endEditing(true)
        getWeather(city: city)
    }
 
    // MARK: - open detail view
    private func navToDetail() {
        guard let w = self.weather, let list = w.list, list.count > 0 else {
            return
        }
        
        if let detailVC = self.storyboard?.instantiateViewController(identifier: "detailvc") as? DetailViewController {
            detailVC.weather = list[0]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    private func showLoader() {
        HUD.show(.progress)
    }
    
    private func hideLoader() {
        HUD.hide(afterDelay: 1.0)
    }
}

