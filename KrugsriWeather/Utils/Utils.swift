//
//  Utils.swift
//  KrugsriWeather
//
//  Created by weerapon on 18/5/2564 BE.
//

import Foundation

class Utils {
    
    class func calucateTempeture(unit: WeatherUnit, value: Double) -> Double {
        switch unit {
            case .celsius:
                return (value - 32) / 1.8
            case .fahrenheit:
                return (value * 1.8) + 32
        }
    }
    
}
