//
//  DailyForecastDataSource.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

// MARK: -

final class DailyForecastDataSource: NSObject {

    // MARK: Properties

    private let hourlyForecasts: [HourlyForcastViewModel]

    // MARK: - Initialisation

    init(hourlyForecasts: [HourlyForcastViewModel]) {
        self.hourlyForecasts = hourlyForecasts
    }

    convenience init(weatherForecasts: [WeatherForecast]) {
        let hourlyForecasts = weatherForecasts
            .map { (weather: WeatherForecast) -> HourlyForcast in
                if let weather = weather as? HourlyForcast {
                    return weather
                }
                return HourlyForcast(weather: weather)
            }
        self.init(hourlyForecasts: hourlyForecasts)
    }
}

// MARK: -

extension DailyForecastDataSource:  UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyForecasts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: HourlyForecastCell = collectionView.dequeueExternalCell(for: indexPath)
            else { fatalError("Setup the cell") }
        cell.imageFetcher = ImageDownloader.shared
        cell.render(forecast: hourlyForecasts[indexPath.item])
        return cell
    }
}
