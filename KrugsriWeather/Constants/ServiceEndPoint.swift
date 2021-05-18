//
//  ServiceEndPoint.swift
//  KrugsriWeather
//
//  Created by weerapon on 17/5/2564 BE.
//

import Foundation

struct ServiceEndPoint {
    
    static let BASE_URL = "http://api.openweathermap.org/data/2.5"
    static let IMAGE_URL = "http://openweathermap.org/img/wn/"
    
    struct Weather {
        static let getWeather = "/weather"
        static let getForecastWeather = "/forecast"
    }
    
}
