//
//  HourlyForecastCell.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

// MARK: -

protocol HourlyForcastModel {

    var hour: String { get }

    var temperature: String { get }

    var minTemp: String { get }

    var maxTemp: String { get }

    var description: String { get }

    var iconUrl: URL? { get }

}

// MARK: -

final class HourlyForecastCell: UICollectionViewCell, ExternalCell {

    // MARK: IBOutlets

    @IBOutlet weak private var hourLabel: UILabel!

    @IBOutlet weak private var temperatureLabel: UILabel!

    @IBOutlet weak private var minTempLabel: UILabel!

    @IBOutlet weak private var maxTempLabel: UILabel!

    @IBOutlet weak private var descriptionLabel: UILabel!

    @IBOutlet weak private var iconImageView: UIImageView!

    // MARK: - Public methods

    func render(forecast: HourlyForcastModel) {
        hourLabel.text = forecast.hour
        temperatureLabel.text = forecast.temperature
        minTempLabel.text = forecast.minTemp
        maxTempLabel.text = forecast.maxTemp
        descriptionLabel.text = forecast.description
        iconImageView.isHidden = forecast.iconUrl == nil

        if let iconUrl = forecast.iconUrl {
            // TODO: Icon handling
        }
    }

}
