//
//  Weather.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

struct Weather: Codable {

    /** Weather condition id */
    let id: Int
    /** Group of weather parameters */
    let main: String
    /** Weather condition within the group */
    let description: String
    /** Weather icon id */
    let icon: String

}
