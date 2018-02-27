//
//  ForecastData.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

struct ForecastData: Codable {
    
    /** Time of data forecasted, unix, UTC */
    let dt: Date
    /** Main numeric infos of the weather */
    let main: MainInfo
    /** Weather conditions */
    let weather: [Weather]
}

extension ForecastData: WeatherForecast {

    var date: Date {
        return dt
    }

    var temp: Int {
        return Int(main.temp.rounded())
    }

    var min: Int {
        return Int(main.tempMin.rounded())
    }

    var max: Int {
        return Int(main.tempMax.rounded())
    }

    var description: String {
        // I know how to use reduce, but my experience
        // is that .map() with .joined() is faster
        // https://gist.github.com/danieltmbr/1e71c0d3476b0367b60ad77ad7185eb4
        return weather
            .map { $0.description }
            .joined(separator: ", ")
    }

    var iconId: String? {
        return weather.first?.icon
    }
}
