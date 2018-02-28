//
//  ForecastService.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 27..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

// MARK: - 

protocol WeatherForecast {

    var date: Date { get }

    var temp: Int { get }

    var min: Int { get }

    var max: Int { get }

    var description: String { get }

    var iconId: String? { get }

}

// MARK: -

protocol ForecastService {
    func fetchForecasts(for place: Place, callback: @escaping ([WeatherForecast]?, Error?) -> Void)
}
