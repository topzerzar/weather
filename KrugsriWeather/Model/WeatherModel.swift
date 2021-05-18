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
        self.id = json["id"].number
        self.main = json["main"].string
        self.description = json["description"].string
        self.icon = json["icon"].string
    }
    
}
