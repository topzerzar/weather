//
//  WeatherModel.swift
//  KrugsriWeather
//
//  Created by weerapon on 18/5/2564 BE.
//

import SwiftyJSON

class MainTemperatureModel {
    
    var feelsLike: Double?
    var tempMin: Double?
    var tempMax: Double?
    var currentTemp: Double?
    var pressure: Double?
    var humidity: Double?
    
    init(from json: JSON) {
        self.feelsLike = json["feels_like"].double
        self.tempMin = json["temp_min"].double
        self.tempMax = json["temp_max"].double
        self.currentTemp = json["temp"].double
        self.pressure = json["pressure"].double
        self.humidity = json["humidity"].double
    }
    
}
