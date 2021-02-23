//
//  Weather.swift
//  weatherdemo
//
//  Created by iMac on 2/18/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather: Mappable {
    var code: String?
    var message: Int?
    var cnt: Int?
    var list: [WeatherSub]?
    
    init() {
    }

    required init?(map _: Map) {}
    
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        cnt <- map["cnt"]
        list <- map["list"]
    }
    
}

class WeatherSub: Mappable {
    var dt: Int?
    var visibility: Int?
    var dt_text: String?
    var main: MainInfo?
    var weather: [SkyInfo]?
    var clouds: CloudInfo?
    var wind: WindInfo?
    
    init() {
    }

    required init?(map _: Map) {}
    
    func mapping(map: Map) {
        dt <- map["dt"]
        visibility <- map["visibility"]
        dt_text <- map["dt_text"]
        main <- map["main"]
        weather <- map["weather"]
        clouds <- map["clouds"]
        wind <- map["wind"]
    }
}

class MainInfo: Mappable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var sea_level: Int?
    var grnd_level: Int?
    var humidity: Int?
    var temp_kf: Double?
    
    init() {
    }

    required init?(map _: Map) {}
    
    func mapping(map: Map) {
        temp <- map["temp"]
        feels_like <- map["feels_like"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
        pressure <- map["pressure"]
        sea_level <- map["sea_level"]
        grnd_level <- map["grnd_level"]
        humidity <- map["humidity"]
        temp_kf <- map["temp_kf"]
    }
}

class SkyInfo: Mappable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    init() {
    }

    required init?(map _: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}

class CloudInfo: Mappable {
    var all: Int?
    
    init() {
    }

    required init?(map _: Map) {}
    
    func mapping(map: Map) {
        all <- map["all"]
    }
    
}

class WindInfo: Mappable {
    var speed: Double?
    var deg: Int?
    
    init() {
    }

    required init?(map _: Map) {}
    
    func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
    }
}
