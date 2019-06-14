//
//  WeatherIconManager.swift
//  Weather_App_API
//
//  Created by Vlad Tagunkov on 14/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import Foundation
import  UIKit

enum WeatherIconManager: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Slett = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    case UnpredictedIcon = "unpredited-icon"
    
    init(rawValue: String){
        switch rawValue {
        case "clear-day":
            self = .ClearDay
        case "clear-night":
            self = .ClearNight
        case "rain":
            self = .Rain
        case "snow":
            self = .Snow
        case "sleet":
            self = .Slett
        case "wind":
            self = .Wind
        case "fog":
            self = .Fog
        case "cloudy":
            self = .Cloudy
        case "partly-cloudy-day":
            self = .PartlyCloudyDay
        case "partly-cloudy-night":
            self = .PartlyCloudyNight
        default:
            self = .UnpredictedIcon
        }
    }
}

extension WeatherIconManager {
    var image: UIImage{
        return UIImage(named: self.rawValue)!
    }
}
