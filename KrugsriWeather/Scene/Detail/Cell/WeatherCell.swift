//
//  WeatherCell.swift
//  KrugsriWeather
//
//  Created by weerapon on 18/5/2564 BE.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minTemperture: UILabel!
    @IBOutlet weak var maxTemperture: UILabel!
    
    func setData(viewModel: WeatherDetailViewModel.ForecastWeatherModel) {
        self.dateLabel.text = viewModel.day
        self.minTemperture.text = viewModel.minTemperture
        self.maxTemperture.text = viewModel.maxTemperture
    }
    
}
