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
