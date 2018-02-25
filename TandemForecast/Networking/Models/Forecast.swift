//
//  Forecast.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

struct Forecast: Codable {

    /** Forecast informations */
    let list: [ForecastData]
    /** City of the forecast */
    let city: City
    
}
