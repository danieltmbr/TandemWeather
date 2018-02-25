//
//  MainInfo.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

struct MainInfo: Codable {

    /** Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.*/
    let temp: Double
    /** Minimum temperature at the moment of calculation. This is deviation from 'temp' */
    let tempMin: Double
    /** Maximum temperature at the moment of calculation. This is deviation from 'temp' */
    let tempMax: Double
    /** Atmospheric pressure on the sea level by default, hPa */
    let pressure: Double
    /** Humidity, % */
    let humidity: Int

    private enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}
