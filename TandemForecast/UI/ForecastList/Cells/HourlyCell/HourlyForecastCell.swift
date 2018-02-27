//
//  HourlyForecastCell.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

// MARK: -

protocol HourlyForcastViewModel {

    var hour: String { get }

    var temperature: String { get }

    var minTemp: String { get }

    var maxTemp: String { get }

    var description: String { get }

    var iconId: String? { get }

}

// MARK: -

final class HourlyForecastCell: UICollectionViewCell, ExternalCell {

    // MARK: Properties

    var imageFetcher: ImageFetcher?

    private var imageDownloadTask: CancelableRequest?

    // MARK: - IBOutlets

    @IBOutlet weak private var hourLabel: UILabel!

    @IBOutlet weak private var temperatureLabel: UILabel!

    @IBOutlet weak private var minTempLabel: UILabel!

    @IBOutlet weak private var maxTempLabel: UILabel!

    @IBOutlet weak private var descriptionLabel: UILabel!

    @IBOutlet weak private var iconImageView: UIImageView!

    // MARK: - Public methods

    override func prepareForReuse() {
        super.prepareForReuse()
        imageDownloadTask?.cancel()
    }

    func render(forecast: HourlyForcastViewModel) {
        hourLabel.text = forecast.hour
        temperatureLabel.text = forecast.temperature
        minTempLabel.text = forecast.minTemp
        maxTempLabel.text = forecast.maxTemp
        descriptionLabel.text = forecast.description
        iconImageView.isHidden = forecast.iconId == nil || imageFetcher == nil

        if let iconId = forecast.iconId,
            let imageFetcher = imageFetcher {

            imageDownloadTask = imageFetcher.fetchIcon(id: iconId, callback: { [weak self] (image, _) in
                self?.imageDownloadTask = nil
                DispatchQueue.main.async {
                    self?.iconImageView.image = image
                }
            })
        }
    }
}
