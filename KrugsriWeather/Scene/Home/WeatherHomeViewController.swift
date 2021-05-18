//
//  WeatherHomeViewController.swift
//  KrugsriWeather
//
//  Created by weerapon on 13/5/2564 BE.
//

import UIKit

protocol WeatherHomeView: BaseView {
    func displayWeather(viewModel: WeatherHomeViewModel.WeatherModel)
    func displayErrorDialog(viewModel: WeatherHomeViewModel.ErrorModel)
    func displayNotFound(viewModel: WeatherHomeViewModel.ErrorModel)
    func displayInlineError(viewModel: WeatherHomeViewModel.InlineErrorMessageModel)
    func displayActiveCelsiusUnit(viewModel: WeatherHomeViewModel.WeatherActiveUnit)
    func displatActiveFahrenheitUnit(viewModel: WeatherHomeViewModel.WeatherActiveUnit)
}

protocol WeatherHomeRouter: NSObjectProtocol {
    func navigateToDetailViewController(city: String, unit: WeatherUnit)
}

class WeatherHomeViewController: BaseViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var citiNameLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var notfoundLabel: UILabel!
    @IBOutlet weak var inlineErrorLable: UILabel!
    @IBOutlet weak var celsiusButton: UIButton!
    @IBOutlet weak var fahrenheitButton: UIButton!

    let presenter: WeatherHomePresenter = WeatherHomePresenter(service: WeatherHomeService())

    override func awakeFromNib() {
        super.awakeFromNib()
    
        presenter.attachView(view: self)
        presenter.attachRouter(router: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialInstances()
        self.initialNavigation()
    }
    
    private func initialInstances() {
        self.detailStackView.isHidden = true
        self.inlineErrorLable.isHidden = true
        self.cityTextField.delegate = self
        self.cityTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.presenter.selectWeatherUnit(unit: WeatherUnit.celsius)
    }
    
    private func initialNavigation() {
        let forecastButton = UIBarButtonItem(
            title: "Forecast",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.onPressedForecastButton)
        )
        
        self.navigationItem.rightBarButtonItem = forecastButton
    }
    
    @IBAction func onPressedSelectCelsius() {
        self.presenter.selectWeatherUnit(unit: WeatherUnit.celsius)
        self.presenter.searchWeather()
    }
    
    @IBAction func onPressedSelectFahrenheit() {
        self.presenter.selectWeatherUnit(unit: WeatherUnit.fahrenheit)
        self.presenter.searchWeather()
    }
    
    @IBAction func onPressedSearch() {
        self.presenter.searchWeather()
        self.cityTextField.resignFirstResponder()
    }
    
    @objc
    private func onPressedForecastButton() {
        self.presenter.navigateToDetail()
    }
    
    @objc
    private func textFieldDidChange(textField: UITextField) {
        self.presenter.setCity(city: textField.text)
    }
}

extension WeatherHomeViewController: WeatherHomeView {
    
    func displayWeather(viewModel: WeatherHomeViewModel.WeatherModel) {
        self.detailStackView.isHidden = false
        
        self.citiNameLabel.text = viewModel.cityName
        self.tempLabel.text = viewModel.currentTemp
        self.humidityLabel.text = viewModel.humidity
    }
    
    func displayActiveCelsiusUnit(viewModel: WeatherHomeViewModel.WeatherActiveUnit) {
        self.celsiusButton.setTitleColor(viewModel.activeColor, for: .normal)
        self.fahrenheitButton.setTitleColor(viewModel.inActiveColor, for: .normal)
    }
    
    func displatActiveFahrenheitUnit(viewModel: WeatherHomeViewModel.WeatherActiveUnit) {
        self.celsiusButton.setTitleColor(viewModel.inActiveColor, for: .normal)
        self.fahrenheitButton.setTitleColor(viewModel.activeColor, for: .normal)
    }
    
    func displayInlineError(viewModel: WeatherHomeViewModel.InlineErrorMessageModel) {
        self.inlineErrorLable.text = viewModel.message
        self.inlineErrorLable.isHidden = false
    }
    
    func displayNotFound(viewModel: WeatherHomeViewModel.ErrorModel) {
        self.notfoundLabel.text = viewModel.message
        self.notfoundLabel.isHidden = false
    }
    
    func displayErrorDialog(viewModel: WeatherHomeViewModel.ErrorModel) {
        self.alertDialog(
            title: viewModel.title,
            message: viewModel.message,
            callback: viewModel.callback
        )
    }
    
}

extension WeatherHomeViewController: WeatherHomeRouter {
    func navigateToDetailViewController(city: String, unit: WeatherUnit) {
        let storyboard = UIStoryboard(name: "WeatherDetailStoryboard", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(
            identifier: "detailScreen"
        ) as? WeatherDetailViewController {
            
            vc.city = city
            vc.unit = unit
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension WeatherHomeViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.detailStackView.isHidden = true
        self.notfoundLabel.isHidden = true
        self.inlineErrorLable.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if cityTextField.returnKeyType == UIReturnKeyType.search {
            self.presenter.searchWeather()
            self.cityTextField.resignFirstResponder()
            return true
        }
        
        return false
    }
}
