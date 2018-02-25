//
//  DailyForecastDataSource.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

final class DailyForecastDataSource: NSObject {

    private let hourlyForecasts: [HourlyForcastModel]

    init(hourlyForecasts: [HourlyForcastModel]) {
        self.hourlyForecasts = hourlyForecasts
    }

    convenience init(forecasts: [ForecastData]) {
        let hourlyForecasts = forecasts.map { (data: ForecastData) -> HourlyForcastViewModel in
            // I know how to use reduce, but my experiences
            // is that .map() with .joined() is faster
            // https://gist.github.com/danieltmbr/1e71c0d3476b0367b60ad77ad7185eb4
            let desc = data.weather
                .map { $0.description }
                .joined(separator: ", ")

            return HourlyForcastViewModel(
                date: data.dt,
                temp: Int(data.main.temp.rounded()),
                min: Int(data.main.tempMin.rounded()),
                max: Int(data.main.tempMax.rounded()),
                description: desc,
                iconUrl: URL(string: data.weather.first?.icon ?? "")
            )
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
        cell.render(forecast: hourlyForecasts[indexPath.item])
        return cell
    }
}
