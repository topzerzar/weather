//
//  Weather.swift
//  KrugsriWeather
//
//  Created by weerapon on 18/5/2564 BE.
//

import SwiftyJSON

class CurrentWeatherModel {
    
    var id: NSNumber?
    var cityName: String?
    var timezone: NSNumber?
    var detail: MainTemperatureModel?
    var weather: [WeatherModel]?
    
    init(from json: JSON) {
        self.id = json["id"].number
        self.cityName = json["name"].string
        self.timezone = json["timezone"].number
        self.detail = MainTemperatureModel(from: json["main"])
        
        self.weather = json["weather"].arrayValue.compactMap { (item) -> WeatherModel in
            return WeatherModel(from: item)
        }
    }
}
