//
//  ForecastListViewModel.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

// MARK: -

protocol ForecastPresenter: class, LoaderPresenter {
    func update(forecasts: [DailyForecastViewModel])
    func displayError(_ error: Error)
}

// MARK: -

final class ForecastList: ForecastListViewModel {

    // MARK: Properties

    private let service: ForecastService

    private var forecasts: [DailyForecastViewModel] = []

    let locations: [Place]

    var location: Place {
        didSet { getForecasts() }
    }

    weak var presenter: ForecastPresenter?

    // MARK: - Lifecycle methods

    init(service: ForecastService, locations: [String]) {
        guard locations.count > 0 else { fatalError("Please provide at least one location") }
        self.service = service
        self.locations = locations
        self.location = locations[0]
    }

    // MARK: - Public methods

    func getForecasts() {
        displayLoader(true)
        service.fetchForecasts(for: location) { [weak self] (forecast, error) in
            guard let strongSelf = self else { return }
            strongSelf.displayLoader(false)

            if let forecast = forecast {
                strongSelf.updatePresenter(
                    with: strongSelf.convert(forecast)
                )
            } else if let error = error {
                strongSelf.updatePresenter(with: error)
            } else {
                assertionFailure("Should not happen")
            }
        }
    }

    // MARK: - Private methods

    private func updatePresenter(with forecasts: [DailyForecastViewModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.update(forecasts: forecasts)
        }
    }

    private func updatePresenter(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.displayError(error)
        }
    }

    private func displayLoader(_ display: Bool) {
        DispatchQueue.main.async { [weak self] in
            display ? self?.presenter?.displayLoader() : self?.presenter?.dismissLoader()
        }
    }

    private func convert(_ weatherForecasts: [WeatherForecast]) -> [DailyForecastViewModel] {
        return groupForecastsByDate(weatherForecasts).map {
            let dataSource = DailyForecastDataSource(weatherForecasts: $0.1)
            return DailyForecast(date: $0.0, dataSource: dataSource)
        }
    }

    private func groupForecastsByDate(_ weatherForecasts: [WeatherForecast]) -> [(Date, [WeatherForecast])] {
        guard let firstData = weatherForecasts.first
            else { return [] }

        let calendar = Calendar.current
        var groups: [(Date, [WeatherForecast])] = []
        var date = firstData.date
        var currentGroup: [WeatherForecast] = []

        for weather in weatherForecasts {
            if calendar.isDate(weather.date, inSameDayAs: date) {
                currentGroup.append(weather)
            } else {
                groups.append((date, currentGroup))
                date = weather.date
                currentGroup = [weather]
            }
        }
        groups.append((date, currentGroup))
        return groups
    }
}
