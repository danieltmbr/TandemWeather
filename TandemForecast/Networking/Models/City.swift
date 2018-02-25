//
//  City.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

struct City: Codable {
    
    /** City ID */
    let id: Int
    /** City name */
    let name: String
    /** City geo location */
    let coord: Coord
    /** Country code (GB, JP etc.) */
    let country: String
    /** Population of the city */
    let population: Int

}

struct Coord: Codable {

    /** Geo location, latitude */
    let lat: Double
    /** City geo location, longitude */
    let lon: Double

}
