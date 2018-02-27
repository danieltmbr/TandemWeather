//
//  DailyForecastDataSource.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

final class DailyForecastDataSource: NSObject {

    private let hourlyForecasts: [HourlyForcastViewModel]

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
