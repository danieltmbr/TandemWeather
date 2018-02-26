//
//  HourlyForeCastViewModel.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

struct HourlyForcastViewModel {

    var date: Date

    var temp: Int

    var min: Int

    var max: Int

    var description: String

    var iconUrl: URL?
}

extension HourlyForcastViewModel: HourlyForcastModel {

    var hour: String {
        return date.localizedHour
    }

    var temperature: String {
        return "\(temp)°C"
    }

    var minTemp: String {
        return "\(min)°C"
    }

    var maxTemp: String {
        return "\(max)°C"
    }
}
