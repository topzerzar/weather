//
//  WeatherDetailViewModel.swift
//  KrugsriWeather
//
//  Created by weerapon on 13/5/2564 BE.
//

import UIKit

struct WeatherDetailViewModel {

    struct WeatherModel {
        var cityName: String
        var forecastsWeather: [WeatherDetailViewModel.ForecastWeatherModel]
    }
    
    struct ForecastWeatherModel {
        var day: String
        var minTemperture: String
        var maxTemperture: String
    }
    
    struct ErrorModel {
        var title: String
        var message: String
        var callback: ((UIAlertAction) -> Void)?
    }
    
}
