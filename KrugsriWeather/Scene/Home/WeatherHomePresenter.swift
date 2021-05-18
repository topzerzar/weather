//
//  WeatherHomePresenter.swift
//  KrugsriWeather
//
//  Created by weerapon on 13/5/2564 BE.
//

import UIKit

protocol WeatherHomePresenterInterface {
    func setCity(city: String?)
    func searchWeather()
    func navigateToDetail()
    func selectWeatherUnit(unit: WeatherUnit)
}

class WeatherHomePresenter: WeatherHomePresenterInterface {

    private var service: WeatherHomeService!
    weak private var view: WeatherHomeView!
    weak private var router : WeatherHomeRouter!
    
    private var city: String?
    private var unit: WeatherUnit = WeatherUnit.celsius
    private var result: CurrentWeatherModel?
    
    init(service: WeatherHomeService) {
        self.service = service
    }
    
    func attachRouter(router: WeatherHomeRouter) {
        self.router = router
    }
    
    func attachView(view: WeatherHomeView) {
        self.view = view
    }
    
    func setCity(city: String?) {
        self.city = city
    }
    
    func selectWeatherUnit(unit: WeatherUnit) {
        self.unit = unit
        
        let viewModel = WeatherHomeViewModel.WeatherActiveUnit(
            activeColor: UIColor.shared.red,
            inActiveColor: UIColor.shared.black
        )
        if unit == .celsius {
            self.view.displayActiveCelsiusUnit(viewModel: viewModel)
        } else {
            self.view.displatActiveFahrenheitUnit(viewModel: viewModel)
        }
    }
    
    func searchWeather() {
        guard let cityData = city, cityData != "" else {
            return self.view.displayInlineError(viewModel: getErrorEmptyCity())
        }
        
        service.searchWeather(
            city: cityData,
            unit: self.unit,
            success: { response in
                self.result = response
                self.transformDataToDisplay(data: response)
            },
            fail: { error in
                if error != nil && error?.code == ResponseCode.notFound.rawValue {
                    return self.view.displayNotFound(
                        viewModel: WeatherHomeViewModel.ErrorModel(
                            title: "",
                            message: "This '\(cityData)' keywords data not found."
                        )
                    )
                }
                return self.view.displayErrorDialog(
                    viewModel: WeatherHomeViewModel.ErrorModel(
                        title: "Service unavaliable",
                        message: "Please try agian."
                    )
                )
            }
        )
    }
    
    func navigateToDetail() {
        guard let cityData = city, cityData != "" else {
            return self.view.displayInlineError(viewModel: getErrorEmptyCity())
        }
        
        self.router.navigateToDetailViewController(city: cityData, unit: self.unit)
    }
    
    private func transformDataToDisplay(data: CurrentWeatherModel) {
        var imageUrl: URL?
        if let weather = data.weather, weather.count > 0, let icon = weather[0].icon {
            let endpoint = ServiceEndPoint.IMAGE_URL + icon + ".png"
            imageUrl = URL(string: endpoint)
        }
        
        let viewModel = WeatherHomeViewModel.WeatherModel(
            cityName: data.cityName ?? "N/A",
            currentTemp: String(format: "%.2f", data.detail?.currentTemp ?? 0.00),
            humidity: String(format: "%.2f", data.detail?.humidity ?? 0.00),
            imageUrl: imageUrl
        )
        
        self.view.displayWeather(viewModel: viewModel)
    }
    
    private func getErrorEmptyCity() -> WeatherHomeViewModel.InlineErrorMessageModel {
        return WeatherHomeViewModel.InlineErrorMessageModel(message: "Please input your city.")
    }
    
}
