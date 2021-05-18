//
//  ForecastTemperatureModel.swift
//  KrugsriWeather
//
//  Created by weerapon on 18/5/2564 BE.
//

import SwiftyJSON

class ForecastTemperatureModel {
    
    var tempDay: Double?
    var tempMin: Double?
    var tempMax: Double?
    var tempNight: Double?
    var tempEve: Double?
    var tempMorn: Double?
    
    init(from json: JSON) {
        self.tempDay = json["day"].double
        self.tempMin = json["min"].double
        self.tempMax = json["max"].double
        self.tempNight = json["night"].double
        self.tempEve = json["eve"].double
        self.tempMorn = json["morn"].double
    }
    
}
