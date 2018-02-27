//
//  ForecastService.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 27..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

protocol WeatherForecast {

    var date: Date { get }

    var temp: Int { get }

    var min: Int { get }

    var max: Int { get }

    var description: String { get }

    var iconId: String? { get }

}

protocol ForecastService {
    func fetchForecasts(forCity city: String, callback: @escaping ([WeatherForecast]?, Error?) -> Void)
}
