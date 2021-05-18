//
//  ForecastModel.swift
//  KrugsriWeather
//
//  Created by weerapon on 18/5/2564 BE.
//

import SwiftyJSON

class ForecastWeatherModel {
    
    var dateTime: NSNumber?
    var detail: MainTemperatureModel?
    
    init(from json: JSON) {
        self.dateTime = json["dt"].number
        self.detail = MainTemperatureModel(from: json["main"])
    }
}
