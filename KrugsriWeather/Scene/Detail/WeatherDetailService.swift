//
//  WeatherDetailService.swift
//  KrugsriWeather
//
//  Created by weerapon on 13/5/2564 BE.
//

import UIKit

class WeatherDetailService {
    
    
    func searchForecastWeather(
        city: String,
        unit: WeatherUnit,
        success: @escaping (_ model: [ForecastWeatherModel]) -> (),
        fail: @escaping (_ model: ErrorModel?) -> ()
    ) {
        
        let params = [
            "q": city,
            "units": unit.rawValue,
            "appid": Bundle.main.object(forInfoDictionaryKey: "api_key")
        ] as [String : AnyObject]
        
        let api = APIManager.init(endpoint: ServiceEndPoint.Weather.getForecastWeather, method: .get)
        api.request(
            parameters: params,
            headersAdditional: [:],
            encoding: nil,
            fail: { (status, json) in
                if let errorJson = json {
                    let error = ErrorModel(from: errorJson)
                    return fail(error)
                }
                
                return fail(nil)
            },
            success: { response in
                let model = response["list"].arrayValue.compactMap { (item) -> ForecastWeatherModel in
                    return ForecastWeatherModel(from: item)
                }
                
                success(model)
            }
        )
    }
}
