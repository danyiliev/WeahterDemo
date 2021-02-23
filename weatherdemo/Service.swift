//
//  Service.swift
//  weatherdemo
//
//  Created by iMac on 2/18/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxAlamofire
import ObjectMapper
import Moya
import Alamofire
import SwiftJWT


class Service {
    var API_KEY = "65d00499677e59496ca2f318eb68c049"
//    let baseUrl = "https://portal.midweststreams.com"
    let baseUrl = "https://api.openweathermap.org/data/2.5"
    let GET_WEATHER = "/forecast"
    
    let disposeBag = DisposeBag()
    
    var remainServices: Int = 0
    var storedServices: Int = 0
    
    private static var sharedService: Service = {
        let service = Service()
        
        return service
    }()
    
    // MARK: - Accessors
    class func shared() -> Service {
        return sharedService
    }
    
    // MARK: - HTTP header
    func header() -> Alamofire.HTTPHeaders? {
        return nil
    }
        
    // get weahter information about the city
    func getWeatherList(city: String) -> Observable<Weather?> {
        let params: [String:Any] = ["q": city, "appid": API_KEY]
        return RxAlamofire.requestString(.get, "\(baseUrl)\(GET_WEATHER)", parameters: params, headers: nil).map { (result, json) -> Weather? in
            Mapper<Weather>().map(JSONString: json)
        }.catchError { (error) -> Observable<Weather?> in
            return Observable.just(nil)
        }
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from json: Any) throws -> Self {
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        return try decoder.decode(Self.self, from: data)
    }
}

extension Mapper {
    public func mapArray(data: Any) -> [N]? {
        if let str = data as? String {
            return Mapper<N>().mapArray(JSONString: str)
        } else {
            return nil
        }
    }
}
