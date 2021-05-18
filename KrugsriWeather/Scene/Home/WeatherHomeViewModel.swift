//
//  WeatherHomeViewModel.swift
//  KrugsriWeather
//
//  Created by weerapon on 13/5/2564 BE.
//

import UIKit

struct WeatherHomeViewModel {

    struct ErrorModel {
        var title: String
        var message: String
        var callback: ((UIAlertAction) -> Void)?
    }
    
    struct InlineErrorMessageModel {
        var message: String
    }
    
    struct WeatherModel {
        var cityName: String
        var currentTemp: String
        var humidity: String
    }
    
    struct WeatherActiveUnit {
        var activeColor: UIColor
        var inActiveColor: UIColor
    }
}
