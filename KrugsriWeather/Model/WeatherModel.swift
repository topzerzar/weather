//
//  Weather.swift
//  KrugsriWeather
//
//  Created by weerapon on 18/5/2564 BE.
//

import SwiftyJSON

class WeatherModel {
    
    var id: NSNumber?
    var main: String?
    var description: String?
    var icon: String?
    
    init(from json: JSON) {
        self.id = json["feels_like"].number
        self.main = json["temp_min"].string
        self.description = json["temp_max"].string
        self.icon = json["temp"].string
    }
    
}
