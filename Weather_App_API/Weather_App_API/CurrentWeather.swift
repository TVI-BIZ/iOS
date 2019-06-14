//
//  CurrentWeather.swift
//  Weather_App_API
//
//  Created by Vlad Tagunkov on 14/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let appearanceTemperature: Double
    let humidity: Double
    let pressure: Double
    let icon: UIImage
    
}
extension CurrentWeather: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
        let apparentTemperature = JSON["apparentTemperature"] as? Double,
        let humidity = JSON["humidity"] as? Double,
        let pressure = JSON["pressure"] as? Double,
            let iconString = JSON["icon"] as? String else {
                return nil
        }
        let icon = WeatherIconManager(rawValue: iconString).image
        
        self.humidity = humidity
        self.temperature = temperature
        self.appearanceTemperature = apparentTemperature
        self.pressure = pressure
        self.icon = icon
    }
}

extension CurrentWeather {
    var pressureString: String {
        return ("\(Int(pressure * 0.750062)) mm")
    }
    var humidityString: String {
        return "\(Int(humidity * 100)) %"
    }
    var temperatureString: String {
        return "\(Int(5/9 * (temperature - 32)))˚C"
    }
    var appearentTemperatureString: String {
        return "\(Int(5/9 * (appearanceTemperature - 32)))˚C"
    }
    
}
