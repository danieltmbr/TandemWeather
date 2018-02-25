//
//  ForecastListViewModel.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

// MARK: -

protocol ForecastPresenter: class {
    func update(forecasts: [DailyForecastModel])
    func displayError(_ error: Error)
}

// MARK: -

protocol ForecastService {
    func fetchForecasts(forCity city: String, callback: (Forecast?, Error?) -> Void)
}

// MARK: -

final class ForecastListViewModel: ForecastListModel {

    // MARK: Properties

    private let service: ForecastService

    private var forecasts: [DailyForecastModel]

    var cityName: String

    var cityLocation: String?

    weak var presenter: ForecastPresenter?

    // MARK: - Lifecycle methods

    init(service: ForecastService, cityName: String, forecasts: [DailyForecastModel]) {
        self.service = service
        self.cityName = cityName
        self.forecasts = forecasts
    }

    // MARK: - Public methods

    func getForecasts() {
        service.fetchForecasts(forCity: cityName) { [weak self] (forecast, error) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                if let forecast = forecast {
                    strongSelf.updatePresenter(
                        with: strongSelf.convert(forecast: forecast)
                    )
                } else if let error = error {
                    strongSelf.updatePresenter(with: error)
                } else {
                    assertionFailure("Should not happen")
                }
            }
        }
    }

    // MARK: - Private methods

    private func updatePresenter(with forecasts: [DailyForecastModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.update(forecasts: forecasts)
        }
    }

    private func updatePresenter(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.displayError(error)
        }
    }

    private func convert(forecast: Forecast) -> [DailyForecastModel] {
        return groupForecastsByDate(forecast.list).map {
            let dataSource = DailyForecastDataSource(forecasts: $0.1)
            return DailyForecastViewModel(date: $0.0, dataSource: dataSource)
        }
    }

    private func groupForecastsByDate(_ forecastsData: [ForecastData]) -> [(Date, [ForecastData])] {
        guard let firstData = forecastsData.first
            else { return [] }

        let calendar = Calendar.current
        var groups: [(Date, [ForecastData])] = []
        var date = firstData.dt
        var currentGroup: [ForecastData] = []

        for data in forecastsData {
            if calendar.isDate(data.dt, inSameDayAs: date) {
                currentGroup.append(data)
            } else {
                groups.append((date, currentGroup))
                date = data.dt
                currentGroup = [data]
            }
        }

        groups.append((date, currentGroup))
        return groups
    }
}
