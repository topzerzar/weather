//
//  WeatherDetailViewController.swift
//  KrugsriWeather
//
//  Created by weerapon on 13/5/2564 BE.
//

import UIKit

protocol WeatherDetailView: BaseView {
    func displayForecastData(viewModel: WeatherDetailViewModel.WeatherModel)
    func displayErrorDialog(viewModel: WeatherDetailViewModel.ErrorModel)
}

protocol WeatherDetailRouter: NSObjectProtocol {
    func navigateBackToPrevious()
}

class WeatherDetailViewController: BaseViewController {
    
    @IBOutlet weak var citiNameLabel: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!

    let presenter: WeatherDetailPresenter = WeatherDetailPresenter(service: WeatherDetailService())
    
    var city: String?
    var unit: WeatherUnit?
    
    private var cellIdentifier = "weatherCell"
    private var viewModel: WeatherDetailViewModel.WeatherModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    
        presenter.attachView(view: self)
        presenter.attachRouter(router: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialInstances()
        self.registerNibFile()
    }
    
    private func initialInstances() {
        self.forecastTableView.dataSource = self
        self.forecastTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.presenter.setCityName(city)
        self.presenter.setUnit(unit)
        self.presenter.getForecastWeather()
    }
    
    private func registerNibFile() {
        self.forecastTableView.register(
            UINib(nibName: "WeatherCell", bundle: nil),
            forCellReuseIdentifier: cellIdentifier
        )
    }
}

extension WeatherDetailViewController: WeatherDetailView {
    func displayForecastData(viewModel: WeatherDetailViewModel.WeatherModel) {
        self.citiNameLabel.text = viewModel.cityName
        
        self.viewModel = viewModel
        self.forecastTableView.reloadData()
    }
    
    func displayErrorDialog(viewModel: WeatherDetailViewModel.ErrorModel) {
        self.alertDialog(
            title: viewModel.title,
            message: viewModel.message,
            callback: viewModel.callback
        )
    }
}

extension WeatherDetailViewController: WeatherDetailRouter {
    func navigateBackToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WeatherDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.forecastsWeather.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WeatherCell {
            if let data = self.viewModel?.forecastsWeather[indexPath.row] {
                cell.setData(viewModel: data)
            }
            return cell
        }
        
        return UITableViewCell()
    }
}
