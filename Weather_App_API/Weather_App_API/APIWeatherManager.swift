//
//  APIWeatherManager.swift
//  Weather_App_API
//
//  Created by Vlad Tagunkov on 14/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import Foundation

struct Coordinates{
    let latitude: Double
    let longitude: Double
}

enum ForesatType: FinalURLPoint{
    var baseURL: URL {
        return URL(string: "https://api.forecast.io")!
    }
    
    var path: String {
        switch self {
        case .Current(let apiKey, let coordinates):
            return "/forecast/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)"
        }
    }
    
    var request: URLRequest{
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
    
    case Current(apiKey: String, coordinates: Coordinates)
}


final class APIWeatherManager: APIManager {
//    func fetch<T>(request: URLRequest, parse: @escaping ([String : AnyObject]) -> T?, completionHandler: (APIResult<T>) -> Void) where T : JSONDecodable {
//        <#code#>
//    }
//
//    func JSONTaskWith(request: URLRequest, completionHandler: ([String : AnyObject]?, HTTPURLResponse?, Error?) -> Void) -> JSONTask {
//        <#code#>
//    }
    
    var sessionConfiguration: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    } ()
    let apiKey: String

    init(sessionConfiguration: URLSessionConfiguration, apiKey: String){
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }

    convenience init(apiKey: String){
        self.init(sessionConfiguration:  URLSessionConfiguration.default, apiKey: apiKey)
    }
    func fetchCurrentWeatherWith(coordinates: Coordinates, complitionHandler: @escaping (APIResult<CurrentWeather>) -> Void){
        let reqest = ForesatType.Current(apiKey: self.apiKey, coordinates: coordinates).request
        fetch(request: reqest, parse: { (json) -> CurrentWeather? in
            if let dictionary = json["currently"] as? [String: AnyObject] {
               return CurrentWeather(JSON: dictionary)
            } else {
                return nil
            }
            
        }, completionHandler: complitionHandler)
    }
}
