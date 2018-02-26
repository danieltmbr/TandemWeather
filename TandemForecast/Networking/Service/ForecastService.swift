//
//  ForecastService.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 26..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

private struct ApiConstants {

    static let baseUrl: String = "https://api.openweathermap.org/data/2.5/forecast"

    static let apiKey: String = "405d5eac89fc0da96d414e20ab4ca1c3"
}

final class ForecastFetcher: ForecastService {

    // MARK: - Properties

    private let session = URLSession(configuration: .default)
    /** Currently active forecast fetch */
    private var dataTask: URLSessionDataTask?

    // MARK: - Public methods

    func fetchForecasts(forCity city: String, callback: @escaping (Forecast?, Error?) -> Void) {

        guard var urlComponents = URLComponents(string: ApiConstants.baseUrl)
            else { return }
        urlComponents.query = "q=\(city),uk&units=metric&APPID=\(ApiConstants.apiKey)"
        guard let url = urlComponents.url
            else { return }

        dataTask?.cancel()

        dataTask = session.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            guard let data = data
                else { return callback(nil, error) }

            do {
                let decoder = JSONDecoder()
                let forecast = try decoder.decode(Forecast.self, from: data)
                callback(forecast, nil)
            } catch let e {
                callback(nil, e)
            }
        }
        dataTask?.resume()
    }
}
