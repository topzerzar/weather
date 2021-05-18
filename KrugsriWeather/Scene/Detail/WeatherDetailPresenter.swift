//
//  WeatherDetailPresenter.swift
//  KrugsriWeather
//
//  Created by weerapon on 13/5/2564 BE.
//

import UIKit

protocol WeatherDetailPresenterInterface {
    func setCityName(_ name: String?)
    func setUnit(_ unit: WeatherUnit?)
    func getForecastWeather()
}

class WeatherDetailPresenter: WeatherDetailPresenterInterface {

    private var service: WeatherDetailService!
    weak private var view: WeatherDetailView!
    weak private var router : WeatherDetailRouter!
    
    private var cityName: String?
    private var unit: WeatherUnit?
    
    // MARK: - Initializers
    init(service: WeatherDetailService) {
        self.service = service
    }
    
    func attachRouter(router: WeatherDetailRouter) {
        self.router = router
    }
    
    func attachView(view: WeatherDetailView) {
        self.view = view
    }
    
    func setCityName(_ name: String?) {
        self.cityName = name
    }
    
    func setUnit(_ unit: WeatherUnit?) {
        self.unit = unit
    }
    
    func getForecastWeather() {
        guard let name = cityName, let unitTemp = unit else {
            return
        }
        
        self.service.searchForecastWeather(
            city: name,
            unit: unitTemp,
            success: { result in
                self.transformWeather(result)
            },
            fail: { _ in
                self.view.displayErrorDialog(
                    viewModel: WeatherDetailViewModel.ErrorModel(
                        title: "",
                        message: "Service unavaliable.",
                        callback: { _ in 
                            self.router.navigateBackToPrevious()
                        }
                    )
                )
            }
        )
    }
    
    private func transformWeather(_ result: [ForecastWeatherModel]) {
        let groupDataByDate = groupBy(result)
        let forecastList = groupDataByDate.compactMap { (item) -> WeatherDetailViewModel.ForecastWeatherModel in
            return WeatherDetailViewModel.ForecastWeatherModel(
                day: item.dateTime?.timestampToDate(format: .NormalDate) ?? "N/A",
                minTemperture: String(format: "%.2f", item.detail?.tempMin ?? 0.00),
                maxTemperture: String(format: "%.2f", item.detail?.tempMax ?? 0.00)
            )
        }
        
        let viewModel = WeatherDetailViewModel.WeatherModel(
            cityName: self.cityName ?? "N/A",
            forecastsWeather: forecastList
        )
        self.view.displayForecastData(viewModel: viewModel)
    }
    
    private func groupBy(_ result: [ForecastWeatherModel]) -> [ForecastWeatherModel] {
        var filter = [ForecastWeatherModel]()
        var stepDate = Date()
        result.forEach { (item) in
            let itemDate: Date = item.dateTime?.timestampToDate(format: .NormalDate) ?? Date()
            let isSameDay = Calendar.current.isDate(itemDate, equalTo: stepDate, toGranularity: .day)
            
            if !isSameDay {
                filter.append(item)
                stepDate = item.dateTime?.timestampToDate(format: .NormalDate) ?? Date()
            }
        }
        
        return filter
    }
    
}

